import UIKit

/*
 UserDefaults
 An interface to the user’s defaults database, which stores system-wide and app-specific settings.
        or
 UserDefaults is used to store small amounts of data persistently on an Apple device.
 The data remains available even after you close or restart the app.

 Typical uses:
 - User preferences
 - Login state
 - App settings
 - First-launch information
 - Selected theme
 - Simple flags
 */

UserDefaults.standard.set("meghana", forKey: "name")

let userName = UserDefaults.standard.string(forKey: "name")
print(userName ?? "No Name")

let defaults = UserDefaults.standard

defaults.set(true, forKey: "isDarkModeEnabled")
defaults.set(25, forKey: "age")
defaults.set(23.3, forKey: "height")

let name = defaults.string(forKey: "name")
print(name ?? "No Name")

// age was stored as Int, so retrieve it as Int
let age = defaults.integer(forKey: "age")
print(age)

// Login state
let def = UserDefaults.standard

def.set(true, forKey: "login")

if def.bool(forKey: "login") {
    print("User is logged in")
} else {
    print("User is not logged in")
}

// Removing stored data
UserDefaults.standard.removeObject(forKey: "name")

/*
 UserDefaults is not intended for sensitive information.

 Don't use it for:
 - Passwords
 - Credit card information
 - Authentication secrets
 - Private tokens
 */

// UserDefaults
// This value exists only while your app/process is running.

struct User {
    static let Username = "username"
    static let Age = "age"
    static let Gender = "gender"
    static let Active = "active"
    static let Lastseen = "lastseen"
}

// Set default values
let Defaults = UserDefaults.standard

Defaults.set(25, forKey: User.Age)
Defaults.set("meghanaa", forKey: User.Username)
Defaults.set("female", forKey: User.Gender)
Defaults.set(true, forKey: User.Active)
Defaults.set(Date(), forKey: User.Lastseen)

// No need for synchronize()

// Get default values
let userName1 = defaults.string(forKey: User.Username)
let userAge = defaults.integer(forKey: User.Age)
let userGender = defaults.string(forKey: User.Gender)
let userActive = defaults.bool(forKey: User.Active)
let lastSeen = defaults.object(forKey: User.Lastseen)

print("""
User Profile
username  : \(userName1 ?? "")
age       : \(userAge)
gender    : \(userGender ?? "")
active    : \(userActive)
Last Seen : \(lastSeen ?? "")
""")

// Delete the value
defaults.removeObject(forKey: User.Active)

// Re-declaring
let userActive1 = defaults.bool(forKey: User.Active)
print(userActive1)

// Delete values
for key in Array(UserDefaults.standard.dictionaryRepresentation().keys) {
    UserDefaults.standard.removeObject(forKey: key)
}

//// Store and Get Custom Object
//struct Profile: Codable {
//    let username: String
//    let age: Int
//    let gender: String
//    let active: Bool
//    let lastSeen: Date
//}
//
//let myProfile = Profile(
//    username: "Ajay",
//    age: 24,
//    gender: "Male",
//    active: true,
//    lastSeen: Date()
//)
//
// Encode custom object
//let encoder = JSONEncoder()
//if let encodedUser = try? encoder.encode(myProfile) {
//    defaults.set(encodedUser, forKey: "myProfile")
//}
//
//// Get custom object
//if let savedData = defaults.object(forKey: "myProfile") as? Data {
//    let decoder = JSONDecoder()
//    if let savedUser = try? decoder.decode(Profile.self, from: savedData) {
//        print("Saved User: \(savedUser)")
//    }
//}
//
// Remove custom object
defaults.removeObject(forKey: "myProfile")

UserDefaults.standard.set(true,forKey: "has-seen-onboarding")
UserDefaults.standard.set(["AApl","Tsla"],forKey: "fav-Stocks")
print(UserDefaults.standard.bool(forKey: "has-seen-onboarding" ))
print(UserDefaults.standard.array(forKey: "fav-Stocks") ?? "no")

//extension UserDefaults {
//    @MainActor static let group = UserDefaults(suiteName: "group.your.identifier")
//}
//UserDefaults.group?.set(["AApl","Tsla"],forKey: "fav-stocks")
//
//struct stock:Decodable{
//    let symbol:String
//}
//UserDefaults.group?.set(stock(symbol: "AAPl"),forKey:"fav-stocks")


//easy to remember
/*Managed
 ↓
Argument
 ↓
App
 ↓
Suite
 ↓
Global
 ↓
Registration*/


//Suite Domain
let SharedDefault = UserDefaults(suiteName:"group.com.myapp.myapp")
SharedDefault?.set(["AApl","TSLA"], forKey: "fav-stocks")


//Registration domains
UserDefaults.standard.register(defaults: ["isDarkMode":false,"fontSize":16])
let darkmode = UserDefaults.standard.bool(forKey: "isDarkMode")
print(darkmode)

//how do we know whether a setting is managed?
let defaults1 = UserDefaults.standard
if defaults1.objectIsForced(forKey: "AllowEditing"){
    print("This Setting is controlled by administrator")
}else{
    print("This setting is controlled by user")
}

//Persistent vs Temporary
/*
 |                       | **Persistent**        | **Temporary**                          |
 | --------------------- | --------------------- | -------------------------------------- |
 | Meaning               | Data is saved         | Data exists only for current execution |
 | Survives app restart? | ✅ Yes                 | ❌ No                                 |
 | Example               | `UserDefaults`        | Normal variable                        |
 | Stored permanently?   | Until removed/changed | Usually memory only                    |

 */

//Persistent
let defaults2 = UserDefaults.standard
defaults2.set("Meghana", forKey: "name")
let name1 = defaults2.string(forKey: "name")
print(name1 ?? "No name")

//Temporary
let name3 = "Ajay"
print(name3)
