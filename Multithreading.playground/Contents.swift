import Foundation
import UIKit
import SwiftUI
import PlaygroundSupport

func calculateSomething() -> Int {
    let a = 10
    let b = 20
    return a + b
}
DispatchQueue.main.async {
    print("Running on main thread")
}
DispatchQueue.global().async {
    print("Running on background thread")
}
DispatchQueue.global().async {
    let result = calculateSomething()
    DispatchQueue.main.async {
        print("Result:", result)
    }
}

//Serial Queue
let serialQueue = DispatchQueue(label: "MySerialQueue")
serialQueue.async {
    print("Task 1")
}
serialQueue.async {
    print("Task 2")
}
serialQueue.async {
    print("Task 3")
}

//concurrent Queue
let concurrentQueue = DispatchQueue(
    label: "MyConcurrentQueue",
    attributes: .concurrent
)
concurrentQueue.async {
    print("Task A")
}
concurrentQueue.async {
    print("Task B")
}
concurrentQueue.async {
    print("Task C")
}

//async /await
func someAsyncOperation() async -> String {
    try? await Task.sleep(for: .seconds(2))
    return "Data received from server"
}
func fetchUser() async -> String {
    print("Start")
    let result = await someAsyncOperation()
    print(result)
    print("Finished")
    return "Meghana"
}

Task {
    print("Task started")
    let user = await fetchUser()
    print("User:", user)
    print("Task finished")
}

//async let
func fetchUser1() async throws -> String {
    try await Task.sleep(for: .seconds(1))
    return "Meghana"
}
func fetchPosts1() async throws -> [String] {
    try await Task.sleep(for: .seconds(1))
    return ["Post 1", "Post 2"]
}
func fetchNotification1() async throws -> String {
    try await Task.sleep(for: .seconds(1))
    return "You have a new notification"
}
Task {
    do {
        async let user = fetchUser1()
        async let posts = fetchPosts1()
        async let notification = fetchNotification1()
        let result = try await (user, posts, notification)
        print("User:", result.0)
        print("Posts:", result.1)
        print("Notification:", result.2)
    } catch {
        print("Error:", error)
    }
}

//task group
func downloadImage(from url: URL) async -> UIImage? {
    try? await Task.sleep(for: .seconds(1))
    return UIImage(systemName: "photo")
}
func downloadAllImages(urls: [URL]) async {
    await withTaskGroup(of: UIImage?.self) { group in
        for url in urls {
            group.addTask {
                await downloadImage(from: url)
            }
        }
        for await image in group {
            if image != nil {
                print("Received image")
            } else {
                print("Image download failed")
            }
        }
    }
}

//actor
actor BankAccount {
    private var balance = 0
    func deposit(_ amount: Int) {
        balance += amount
    }
    func getBalance() -> Int {
        balance
    }
}
let account = BankAccount()
Task {
    await account.deposit(100)
    let balance = await account.getBalance()
    print("Balance:", balance)
}

//MainActor
@MainActor
class UserViewModel {
    var username = ""
    func updateUsername() {
        username = "Meghana"
        print("Username:", username)
    }
}
let viewModel = UserViewModel()
Task { @MainActor in
    viewModel.updateUsername()
}

//Sendable
struct User: Sendable {
    let name: String
    let age: Int
}


//GCD API Example
func fetchData(completion: @escaping @Sendable (String) -> Void) {
    DispatchQueue.global().async {
        print("Fetching data on background thread")
        sleep(2)
        let data = "Data received from server"
        completion(data)
    }
}
fetchData { data in
    print("Data received")
    DispatchQueue.main.async {
        print("Running on main thread")
        print("Result:", data)
    }
}

//DispatchGroup
func login(
    userId: String,
    password: String,
    completion: @escaping @Sendable () -> Void
) {
    DispatchQueue.global().async {
        sleep(2)
        print("Login completed")
        completion()
    }
}
func fetchUserDetail(
    id: String,
    completion: @escaping @Sendable () -> Void
) {
    DispatchQueue.global().async {
        sleep(2)
        print("User details fetched")
        completion()
    }
}
let dispatchGroup = DispatchGroup()
dispatchGroup.enter()
login(
    userId: "1234",
    password: "password"
) {
    dispatchGroup.leave()
}
dispatchGroup.enter()
fetchUserDetail(id: "1234") {
    dispatchGroup.leave()
}
dispatchGroup.notify(queue: .main) {
    print("Execution completed")
}


//multiple API calls with Dispatch Group
func fetchUserProfileDetails(
    id: String,
    completion: @escaping @Sendable () -> Void
) {
    DispatchQueue.global().async {
        sleep(2)
        print("User profile details fetched")
        completion()
    }
}

func fetchUserPublicDetails(
    id: String,
    completion: @escaping @Sendable () -> Void
) {
    DispatchQueue.global().async {
        sleep(3)
        print("User public details fetched")
        completion()
    }
}

class Loader {
    func show() {
        print("Loader shown")
    }
    func hide() {
        print("Loader hidden")
    }
}
let loader = Loader()
let userID = "1234"
@MainActor func startFetch() {
    loader.show()
    let group = DispatchGroup()
    group.enter()
    fetchUserProfileDetails(id: userID) {
        group.leave()
    }
    group.enter()
    fetchUserPublicDetails(id: userID) {
        group.leave()
    }
    group.notify(queue: .main) {
        print("Execution completed")
        loader.hide()
    }
}
startFetch()


//operationQueue
let operationQueue = OperationQueue()
let operation1 = BlockOperation {
    print("Operation 1")
}
let operation2 = BlockOperation {
    print("Operation 2")
}
operation2.addDependency(operation1)
operationQueue.addOperation(operation1)
operationQueue.addOperation(operation2)


//Custom Thread
class CustomThread: Thread {
    override func start() {
        print("Running on Custom Thread")
        super.start()
    }
    override func main() {
        print("Main called for custom thread")
        print("Current thread:", Thread.current)
    }
}
let thread1 = CustomThread()
thread1.start()

//Thread
class ThreadTest {
    func createThread() {
        let thread = Thread {
            self.threadWork()
        }
        thread.name = "Secondary"
        thread.start()
    }
    func threadWork() {
        print("Thread loop running")
        print("Current thread:", Thread.current)
        for i in 1...5 {
            print("Thread running:", i)
            Thread.sleep(forTimeInterval: 1)
        }
        print("Thread completed")
    }
}

let test = ThreadTest()
test.createThread()

//Thread stack size
let thread = Thread()
thread.name = "Secondary"
print(
    "Default thread stack size:",
    thread.stackSize
)
let thread2 = Thread()
thread2.name = "Secondary2"
thread2.stackSize = 4096 * 512
print(
    "Custom thread stack size:",
    thread2.stackSize
)

let queue  = DispatchQueue(label: "com.test.privatequeue",qos: .userInteractive)
DispatchQueue(label: "com.test.privatequeue",qos: .userInteractive)
DispatchQueue(label: "privatequeue",qos: .userInitiated)
DispatchQueue(label: "privatequeue",qos: .background)
DispatchQueue(label: "privatequeue",qos: .unspecified)
DispatchQueue(label: "privatequeue",qos: .utility)
DispatchQueue(label: "privatequeue",qos: .default)



let queue1 = DispatchQueue(label: "com.test.qos", qos: .userInteractive)
let queue2 = DispatchQueue(label: "com.test.qos", qos: .background)
queue1.async{
    for _ in 0...3{
        print("smile")
    }
    queue2.async{
        for _ in 0...3{
            print("super")
        }
    }
}


//What’s the performance cost of calling an async function?
func countFavorites() async throws {
    let favorites = try await decodeFavorites()
    print("Downloaded \(favorites.count) favorites.")
}
func decodeFavorites() async throws -> [Int] {
    let data = try await loadFavorites()
    return try JSONDecoder().decode([Int].self, from: data)
}
func loadFavorites() async throws -> Data {
    let url = URL(string: "https://hws.dev/user-favorites.json")!
    let (data, _) = try await URLSession.shared.data(from: url)
    return data
}



func listPhotos(inGallery gallery: String) async -> [String] {
    return ["Photo1", "Photo2", "Photo3"]
}
func downloadPhoto(named name: String) async -> Data {
    return Data(name.utf8)
}
func show(_ photo: Data) {
    print("Photo downloaded:", String(data: photo, encoding: .utf8) ?? "")
}
Task {
    await withTaskGroup(of: Data.self) { group in
        let photoNames = await listPhotos(inGallery: "Summer Vacation")
        for name in photoNames {
            group.addTask {
                return await downloadPhoto(named: name)
            }
        }
        for await photo in group {
            show(photo)
        }
    }
}


actor PhotoManager {
    var photos: [String] = []
    func addPhoto(_ photo: String) {
        photos.append(photo)
    }
    func getPhotos() -> [String] {
        return photos
    }
}


actor TemperatureLogger {
    var measurements: [Int] = []

    func addMeasurement(_ value: Int) {
        measurements.append(value)
    }
}
extension TemperatureLogger {
    func convertFahrenheitToCelsius() {
        for i in measurements.indices {
            measurements[i] = (measurements[i] - 32) * 5 / 9
        }
    }
}

//Sendable
final class User1: Sendable {
    let name: String
    let age: Int

    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}


//@Sendable
let operation: @Sendable () -> Void = {
    print("Hello")
}

/*
 Concept    Meaning
 Sendable    A type can safely be transferred between concurrency contexts
 @Sendable    A closure can safely be transferred between concurrency contexts
 */


struct TemperatureReading: Sendable {
    var measurement: Int
}
extension TemperatureLogger {
    func addReading(from reading: TemperatureReading) {
        measurements.append(reading.measurement)
    }
}
let logger = TemperatureLogger()
let reading = TemperatureReading(measurement: 45)
Task {
    await logger.addReading(from: reading)
}


func printUsers() async throws{
    guard let url = URL(string: "https://hws.dev/users.csv") else {
            return
        }
    var iterator = url.lines.makeAsyncIterator()
    if let line = try await iterator.next(){
        print("The first user is \(line)")
    }
    for i in 2...5{
        if let line = try await iterator.next(){
            print("User #\(i):\(line)")
        }
    }
    var remainingResults = [String]()
    while let result = try await iterator.next(){
        remainingResults.append(result)
    }
    print("There were \(remainingResults.count) other users.")

}
try? await printUsers()


func shoutQuotes() async throws{
    let url = URL(string: "https://hws.dev/quotes.txt")!
    let uppercaseLines = url.lines.map(\.localizedUppercase)
    for try await line in uppercaseLines {
            print(line)
    }
}
try? await shoutQuotes()


struct Quote {
    let text: String
}
func printQuotes() async throws {
    let url = URL(string: "https://hws.dev/quotes.txt")!
    let quotes = url.lines.map(Quote.init)
    for try await quote in quotes {
        print(quote.text)
    }
}
try? await printQuotes()


func printAnonymousQuotes() async throws {
    let url = URL(string: "https://hws.dev/quotes.txt")!
    let anonymousQuotes = url.lines.filter { $0.contains("Anonymous") }
    for try await line in anonymousQuotes {
        print(line)
    }
}
try? await printAnonymousQuotes()

func printTopQuotes() async throws {
    let url = URL(string: "https://hws.dev/quotes.txt")!
    let topQuotes = url.lines.prefix(5)
    for try await line in topQuotes {
        print(line)
    }
}
try? await printTopQuotes()


func printQuotes1() async throws {
    let url = URL(string: "https://hws.dev/quotes.txt")!
    let anonymousQuotes = url.lines.filter { $0.contains("Anonymous") }
    let topAnonymousQuotes = anonymousQuotes.prefix(5)
    let shoutingTopAnonymousQuotes = topAnonymousQuotes.map(\.localizedUppercase)
    for try await line in shoutingTopAnonymousQuotes {
        print(line)
    }
}
try? await printQuotes1()


func printHighestNumber() async throws {
    let url = URL(string: "https://hws.dev/random-numbers.txt")!
    if let highest = try await url.lines.compactMap(Int.init).max() {
        print("Highest number: \(highest)")
    } else {
        print("No number was the highest.")
    }
}
try? await printHighestNumber()


func printHighestNumber1() async throws {
    let url = URL(string: "https://hws.dev/random-numbers.txt")!
    if let highest = try await url.lines.compactMap(Int.init).max() {
        print("Highest number: \(highest)")
    } else {
        print("No number was the highest.")
    }
}
try? await printHighestNumber1()


struct DoubleGenerator: AsyncSequence {
    struct AsyncIterator: AsyncIteratorProtocol {
        var current = 1
        mutating func next() async ->Int? {
            defer{current &*= 2}
            if current < 0{
                return nil
            }else{
                return current
            }
        }
    }
    func makeAsyncIterator() -> AsyncIterator {
        AsyncIterator()
    }
}
let sequence = DoubleGenerator()
for await number in sequence {
    print(number)
}

struct Message: Decodable, Identifiable {
    let id: Int
    let user: String
    let text: String
}
struct ContentView: View {
    @State private var messages = [Message]()
    var body: some View {
        NavigationStack {
            List(messages) { message in
                VStack(alignment: .leading) {
                    Text(message.user)
                        .font(.headline)
                    Text(message.text)
                }
            }
            .navigationTitle("Inbox")
            .task {
                await fetchData()
            }
        }
    }
    func fetchData() async {
        do {
            let url = URL(string: "https://hws.dev/inbox.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            messages = try JSONDecoder().decode([Message].self, from: data)
        } catch {
            messages = [
                Message(id: 0, user: "Failed to load inbox.", text: "Please try again later.")
            ]
        }
    }
}
