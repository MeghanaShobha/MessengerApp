import UIKit
import Security //used for keychain -it is for security
import Foundation //data  files ,network etc ..
import LocalAuthentication

//Saving Data to Keychain
class KeyChainManager{
    enum KeyChainError:Error{
        case duplicateItem
        case itemNotFound
        case unexpectedStatus(OSStatus)
        case invalidData
    }
    
    
    func save (data: Data,account:String,service:String) throws{
        let query : [String:Any] = [
            kSecClass as String : kSecClassGenericPassword,
            kSecAttrAccount as String : account,
            kSecValueData as String : data,
            kSecAttrService as String : service
        ]
        let status = SecItemAdd(query as CFDictionary, nil)
        switch status{
        case errSecSuccess:
            return
        case errSecDuplicateItem:
            throw KeyChainError.duplicateItem
        default:
            throw KeyChainError.unexpectedStatus(status)
        }
    }
    
    func save(string :String,account:String,service:String)throws {
        guard let data = string.data(using: .utf8) else {
            throw KeyChainError.invalidData
        }
        try save(data: data, account: account, service: service)
    }
}


//Retrieving Data from Keychain
extension KeyChainManager{
    func retrive(account:String,service:String) throws -> Data? {
        let query : [String:Any] = [
            kSecClass as String : kSecClassGenericPassword,
            kSecAttrAccount as String : account,
            kSecAttrService as String : service,
            kSecReturnData as String : true,
            kSecMatchLimit as String : kSecMatchLimitOne
        ]
        var result : AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        switch status{
        case errSecSuccess:
            return result as? Data
        case errSecItemNotFound:
            return nil
        default:
            throw KeyChainError.unexpectedStatus(status)
        }
    }
    func retrieveString(account:String,service:String) throws -> String? {
        guard let data = try? retrive(account: account, service: service) else { return nil }
        return String(data: data, encoding: .utf8)
    }
}


//Updating Keychain Items
extension KeyChainManager{
    func update(data:Data,account:String,service:String)throws{
        let query : [String:Any] = [
            kSecClass as String : kSecClassGenericPassword,
            kSecAttrAccount as String : account,
            kSecAttrService as String : service
        ]
        let attributes : [String:Any] = [
            kSecValueData as String : data
        ]
        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        switch status{
        case errSecSuccess:
            return
        case errSecItemNotFound:
            throw KeyChainError.itemNotFound
        default:
            throw KeyChainError.unexpectedStatus(status)
        }
    }
    func saveOrUpdate(data:Data,account:String,service:String)throws{
        do{
            try save(data: data, account: account, service: service)
        }catch KeyChainError.duplicateItem{
            try update(data: data, account: account, service: service)
        }
    }
}


//Deleting Keychain Items
extension KeyChainManager{
    func delete(account:String,service:String)throws{
        let query : [String:Any] = [
            kSecClass as String : kSecClassGenericPassword,
            kSecAttrAccount as String : account,
            kSecAttrService as String : service
        ]
        let status = SecItemDelete(query as CFDictionary)
        switch status{
        case errSecSuccess,errSecItemNotFound:
            return
        default:
            throw KeyChainError.unexpectedStatus(status)
        }
    }
    func deleteAll(service:String)throws{
        let query : [String:Any] = [
            kSecClass as String : kSecClassGenericPassword,
            kSecAttrService as String : service
        ]
        let status = SecItemDelete(query as CFDictionary)
        switch status{
        case errSecSuccess,errSecItemNotFound:
            return
        default:
            throw KeyChainError.unexpectedStatus(status)
        }
        
    }
}



//Access Control and Biometric Authentication
//Saving Items with Biometric Protection
extension KeyChainManager {
    enum AccessPolicy {
        case always
        case whenUnlocked
        case whenPasscodeSet
        case biometricOnly
        case biometricOrPasscode
    }
    func saveWithBiometric(
        data: Data,
        account: String,
        service: String,
        policy: AccessPolicy = .biometricOrPasscode,
        reason: String = "Authenticate to save credentials"
    ) throws {
        var accessControlFlags: SecAccessControlCreateFlags
        switch policy {
        case .always:
            accessControlFlags = []
        case .whenUnlocked:
            accessControlFlags = []
        case .whenPasscodeSet:
            accessControlFlags = .devicePasscode
        case .biometricOnly:
            accessControlFlags = .biometryCurrentSet
        case .biometricOrPasscode:
            accessControlFlags = [.biometryCurrentSet, .or, .devicePasscode]
        }
        var error: Unmanaged<CFError>?
        guard let accessControl = SecAccessControlCreateWithFlags(
            nil,
            kSecAttrAccessibleWhenUnlockedThisDeviceOnly,
            accessControlFlags,
            &error
        ) else {
            if let error = error?.takeRetainedValue() {
                throw error
            }
            throw KeyChainError.unexpectedStatus(errSecParam)
        }
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecAttrService as String: service,
            kSecValueData as String: data,
            kSecAttrAccessControl as String: accessControl
        ]
        try? delete(account: account, service: service)
        let status = SecItemAdd(query as CFDictionary, nil)

        guard status == errSecSuccess else {
            throw KeyChainError.unexpectedStatus(status)
        }
    }
    func retrieveWithBiometric(
        account: String,
        service: String,
        reason: String = "Authenticate to access credentials"
    ) throws -> Data? {
        let context = LAContext()
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecAttrService as String: service,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecUseAuthenticationContext as String: context,
            kSecUseOperationPrompt as String: reason
        ]

        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)

        switch status {
        case errSecSuccess:
            return result as? Data
        case errSecItemNotFound:
            return nil
        case errSecUserCanceled:
            throw KeyChainError.unexpectedStatus(status)
        default:
            throw KeyChainError.unexpectedStatus(status)
        }
    }
}


//Configuring Accessibility
extension KeyChainManager{
    enum Accessibility{
        case whenUnlocked
        case whenUnlockedThisDeviceOnly
        case afterFirstUnlock
        case afterFirstUnlockThisDeviceOnly
        case whenpasscodeSetThisDeviceOnly
        
        var rawValue: CFString{
            switch self {
            case .whenUnlocked:
                return kSecAttrAccessibleWhenUnlocked
            case .whenUnlockedThisDeviceOnly:
                return kSecAttrAccessibleWhenUnlockedThisDeviceOnly
            case .afterFirstUnlock:
                return kSecAttrAccessibleAfterFirstUnlock
            case .afterFirstUnlockThisDeviceOnly:
                return kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly
            case .whenpasscodeSetThisDeviceOnly:
                return kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly
            }
        }
    }
    func save(data:Data,account:String,service:String,accessibility:Accessibility)throws{
        let query:[String:Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecAttrService as String: service,
            kSecValueData as String: data,
            kSecAttrAccessible as String: accessibility.rawValue
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        switch status {
        case errSecSuccess:
            return
        case errSecDuplicateItem:
            throw KeyChainError.duplicateItem
        default:
            throw KeyChainError.unexpectedStatus(status)
        }
    }
}


//Setting Up Keychain Sharing
extension KeyChainManager{
    func saveToGroup(data:Data,account:String,service:String,accessGroup:String)throws{
        let query:[String:Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecValueData as String: data,
            kSecAttrAccessGroup as String: accessGroup,
        ]
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess || status == errSecDuplicateItem else {
            throw KeyChainError.unexpectedStatus(status)
        }
        if status == errSecDuplicateItem{
            try updateInGroup(account:account,service:service,accessGroup:accessGroup,data:data)
        }
        
    }
    func retrieveFromGroup(account:String,service:String,accessGroup:String)throws->Data?{
        let query:[String:Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecAttrAccessGroup as String: accessGroup,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        var result:AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        switch status{
        case errSecSuccess:
            return result as? Data
        case errSecItemNotFound:
            return nil
        default:
            throw KeyChainError.unexpectedStatus(status)
        }
        
    }
    private func updateInGroup(account: String, service: String, accessGroup: String, data: Data) throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecAttrAccessGroup as String: accessGroup,
            kSecValueData as String: data
        ]
        let attributeToUpdate: [String: Any] = [
            kSecValueData as String: data
        ]
        let status = SecItemUpdate(query as CFDictionary,attributeToUpdate as CFDictionary)
        guard status == errSecSuccess else {
            throw KeyChainError.unexpectedStatus(status)
        }
    }
}


//Storing Internet Credentials
extension KeyChainManager {
    struct InternetCredential {
        let username: String
        let password: String
        let server: String
        let port: Int?
        let path: String?
        let securityDomain: String?
        let protocolType: CFString
    }
    func saveInternetCredential(_ credential: InternetCredential) throws {
        var query: [String: Any] = [
            kSecClass as String: kSecClassInternetPassword,
            kSecAttrAccount as String: credential.username,
            kSecAttrServer as String: credential.server,
            kSecAttrProtocol as String: credential.protocolType,
            kSecValueData as String: credential.password.data(using: .utf8)!
        ]
        if let port = credential.port {
            query[kSecAttrPort as String] = port
        }
        if let path = credential.path {
            query[kSecAttrPath as String] = path
        }
        if let securityDomain = credential.securityDomain {
            query[kSecAttrSecurityDomain as String] = securityDomain
        }

        let status = SecItemAdd(query as CFDictionary, nil)

        switch status {
        case errSecSuccess:
            return
        case errSecDuplicateItem:
            throw KeyChainError.duplicateItem
        default:
            throw KeyChainError.unexpectedStatus(status)
        }
    }
    func retrieveInternetCredential(
        username: String,
        server: String
    ) throws -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassInternetPassword,
            kSecAttrAccount as String: username,
            kSecAttrServer as String: server,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        switch status {
        case errSecSuccess:
            guard let data = result as? Data else { return nil }
            return String(data: data, encoding: .utf8)
        case errSecItemNotFound:
            return nil
        default:
            throw KeyChainError.unexpectedStatus(status)
        }
    }
}

//Building a Complete Keychain Wrapper
import Foundation
import Security
import LocalAuthentication
final class SecureStorage {
    enum StorageError: LocalizedError {
        case dataConversionFailed
        case itemNotFound
        case duplicateItem
        case authenticationFailed
        case accessDenied
        case unknown(OSStatus)
        var errorDescription: String? {
            switch self {
            case .dataConversionFailed:
                return "Failed to convert data"
            case .itemNotFound:
                return "Item not found in Keychain"
            case .duplicateItem:
                return "Item already exists in Keychain"
            case .authenticationFailed:
                return "Biometric authentication failed"
            case .accessDenied:
                return "Access to Keychain was denied"
            case .unknown(let status):
                return "Keychain error: \(status)"
            }
        }
    }
    struct Configuration {
        let service: String
        let accessGroup: String?
        let accessibility: CFString
        let requiresBiometric: Bool
        init(
            service: String,
            accessGroup: String? = nil,
            accessibility: CFString = kSecAttrAccessibleWhenUnlockedThisDeviceOnly,
            requiresBiometric: Bool = false
        ) {
            self.service = service
            self.accessGroup = accessGroup
            self.accessibility = accessibility
            self.requiresBiometric = requiresBiometric
        }
    }
    private let configuration: Configuration
    init(configuration: Configuration) {
        self.configuration = configuration
    }
    convenience init(service: String) {
        self.init(configuration: Configuration(service: service))
    }
    func store<T: Codable>(_ item: T, forKey key: String) throws {
        let data = try JSONEncoder().encode(item)
        try storeData(data, forKey: key)
    }
    func retrieve<T: Codable>(_ type: T.Type, forKey key: String) throws -> T? {
        guard let data = try retrieveData(forKey: key) else {
            return nil
        }
        return try JSONDecoder().decode(T.self, from: data)
    }
    func storeString(_ string: String, forKey key: String) throws {
        guard let data = string.data(using: .utf8) else {
            throw StorageError.dataConversionFailed
        }
        try storeData(data, forKey: key)
    }
    func retrieveString(forKey key: String) throws -> String? {
        guard let data = try retrieveData(forKey: key) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
    func storeData(_ data: Data, forKey key: String) throws {
        try? delete(forKey: key)
        var query = baseQuery(forKey: key)
        query[kSecValueData as String] = data
        if configuration.requiresBiometric {
            var error: Unmanaged<CFError>?
            guard let accessControl = SecAccessControlCreateWithFlags(
                nil,
                configuration.accessibility,
                [.biometryCurrentSet, .or, .devicePasscode],
                &error
            ) else {
                throw error?.takeRetainedValue() ?? StorageError.unknown(errSecParam)
            }
            query[kSecAttrAccessControl as String] = accessControl
        } else {
            query[kSecAttrAccessible as String] = configuration.accessibility
        }

        let status = SecItemAdd(query as CFDictionary, nil)

        guard status == errSecSuccess else {
            throw mapError(status)
        }
    }
    func retrieveData(forKey key: String) throws -> Data? {
        var query = baseQuery(forKey: key)
        query[kSecReturnData as String] = true
        query[kSecMatchLimit as String] = kSecMatchLimitOne

        if configuration.requiresBiometric {
            let context = LAContext()
            query[kSecUseAuthenticationContext as String] = context
            query[kSecUseOperationPrompt as String] = "Access secure storage"
        }
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        switch status {
        case errSecSuccess:
            return result as? Data
        case errSecItemNotFound:
            return nil
        default:
            throw mapError(status)
        }
    }
    func delete(forKey key: String) throws {
        let query = baseQuery(forKey: key)
        let status = SecItemDelete(query as CFDictionary)

        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw mapError(status)
        }
    }
    func deleteAll() throws {
        var query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: configuration.service
        ]

        if let accessGroup = configuration.accessGroup {
            query[kSecAttrAccessGroup as String] = accessGroup
        }

        let status = SecItemDelete(query as CFDictionary)

        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw mapError(status)
        }
    }
    func exists(forKey key: String) -> Bool {
        var query = baseQuery(forKey: key)
        query[kSecReturnData as String] = false

        let status = SecItemCopyMatching(query as CFDictionary, nil)
        return status == errSecSuccess
    }
    private func baseQuery(forKey key: String) -> [String: Any] {
        var query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecAttrService as String: configuration.service
        ]

        if let accessGroup = configuration.accessGroup {
            query[kSecAttrAccessGroup as String] = accessGroup
        }

        return query
    }

    private func mapError(_ status: OSStatus) -> StorageError {
        switch status {
        case errSecItemNotFound:
            return .itemNotFound
        case errSecDuplicateItem:
            return .duplicateItem
        case errSecUserCanceled, errSecAuthFailed:
            return .authenticationFailed
        case errSecInteractionNotAllowed:
            return .accessDenied
        default:
            return .unknown(status)
        }
    }
}


//Storing Authentication Tokens
import Foundation
struct AuthToken: Codable {
    let accessToken: String
    let refreshToken: String
    let expiresAt: Date
    var isExpired: Bool {
        return Date() >= expiresAt
    }
}
class TokenManager {
    private let storage: SecureStorage
    private let tokenKey = "auth_token"
    init() {
        let config = SecureStorage.Configuration(
            service: "com.yourapp.auth",
            requiresBiometric: true
        )
        self.storage = SecureStorage(configuration: config)
    }
    func saveToken(_ token: AuthToken) throws {
        try storage.store(token, forKey: tokenKey)
    }
    func getToken() throws -> AuthToken? {
        return try storage.retrieve(AuthToken.self, forKey: tokenKey)
    }
    func isAuthenticated() -> Bool {
        return storage.exists(forKey: tokenKey)
    }
    func logout() throws {
        try storage.delete(forKey: tokenKey)
    }
}
let tokenManager = TokenManager()
let token = AuthToken(
    accessToken: "eyJhbGciOiJIUzI1NiIs",
    refreshToken: "dGhpcyBpcyBhIHJlZnJlc2g",
    expiresAt: Date().addingTimeInterval(3600)
)
do {
    try tokenManager.saveToken(token)
    print("Token saved securely")
} catch {
    print("Failed to save token: \(error)")
}


//Storing User Credentials
import Foundation
struct UserCredential: Codable {
    let username: String
    let password: String
    let service: String
    let lastUsed: Date
}

class CredentialManager {
    private let storage: SecureStorage
    init() {
        self.storage = SecureStorage(service: "com.yourapp.credentials")
    }
    func saveCredential(_ credential: UserCredential) throws {
        let key = "credential_\(credential.service)"
        try storage.store(credential, forKey: key)
    }
    func getCredential(for service: String) throws -> UserCredential? {
        let key = "credential_\(service)"
        return try storage.retrieve(UserCredential.self, forKey: key)
    }
    func deleteCredential(for service: String) throws {
        let key = "credential_\(service)"
        try storage.delete(forKey: key)
    }
}
let credentialManager = CredentialManager()
let credential = UserCredential(
    username: "john@example.com",
    password: "securePassword123",
    service: "api.example.com",
    lastUsed: Date()
)
try? credentialManager.saveCredential(credential)


//Storing Encryption Keys
import Foundation
import CryptoKit
class EncryptionKeyManager {

    private let storage: SecureStorage
    private let keyIdentifier = "app_encryption_key"

    init() {
        let config = SecureStorage.Configuration(
            service: "com.yourapp.encryption",
            accessibility: kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly
        )
        self.storage = SecureStorage(configuration: config)
    }
    func getOrCreateKey() throws -> SymmetricKey {
        if let keyData = try storage.retrieveData(forKey: keyIdentifier) {
            return SymmetricKey(data: keyData)
        }
        let newKey = SymmetricKey(size: .bits256)
        let keyData = newKey.withUnsafeBytes { Data($0) }
        try storage.storeData(keyData, forKey: keyIdentifier)

        return newKey
    }
    func rotateKey() throws -> SymmetricKey {
        let newKey = SymmetricKey(size: .bits256)
        let keyData = newKey.withUnsafeBytes { Data($0) }
        try storage.storeData(keyData, forKey: keyIdentifier)
        return newKey
    }
}

//Handle Errors Gracefully
//do {
//    let token = try tokenManager.getToken()
//} catch SecureStorage.StorageError.authenticationFailed {
//    showAuthenticationRequiredAlert()
//} catch SecureStorage.StorageError.itemNotFound {
//    navigateToLogin()
//} catch {
//    logError(error)
//    showGenericErrorAlert()
//}


//Clean Up on Logout
//func performLogout() {
//    do {
//        try tokenManager.logout()
//        try credentialManager.deleteAll()
//    } catch {
//        print("Failed to clear keychain: \(error)")
//    }
//    navigateToLogin()
//}
