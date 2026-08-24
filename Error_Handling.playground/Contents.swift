import UIKit

/*Error handling is a way to detect and respond to errors that occur while your program is running. Instead of crashing, Swift lets you throw, catch, and handle errors gracefully.
 Swift uses four keywords:
 Error – A protocol that defines an error type.
 throw – Throws an error.
 throws – Marks a function that can throw an error.
 do-catch – Catches and handles thrown errors.*/

//Create an Error Type
enum loginerror: Error {
    case invalidUsername
    case invalidpassword
}

//Create a Throwing Function
enum Loginerror: Error {
    case invalidUsername
    case invalidpassword
}
func Login(username: String, password: String) throws {
    if username != "admin" {
        throw Loginerror.invalidUsername
    }
    if password != "12345" {
        throw Loginerror.invalidpassword
    }
    print("Login successful")
}

//Handle the Error
do {
    try Login(username: "admin", password: "12345")
} catch {
    print("Login Failed")
}


//Wrong Password Example
do {
    try Login(username: "admin", password: "111123")
} catch {
    print("Login Failed")
}


//Catch Specific Errors
do{
    try Login(username: "admin", password: "111123")
}catch Loginerror.invalidUsername{
    print("Username is incorrect")
}catch Loginerror.invalidpassword{
    print("Password is incorrect")
}


//Multiple Catch Blocks
enum ATMError: Error {
    case insufficientBalance
    case invalidPin
}
func withdraw(amount: Int, pin: Int) throws {
    if pin != 1234 {
        throw ATMError.invalidPin
    }
    if amount < 1000 {
        throw ATMError.insufficientBalance
    }
    print("cash withdraw")
}
do{
    try withdraw(amount: 1000, pin: 1239)
}catch ATMError.invalidPin{
    print("Wrong pin")
}catch ATMError.insufficientBalance{
    print("Insufficient Balance")
}


//Using try? - try? converts the result into an optional.
enum PasswordError: Error {
    case tooshort
}
func CheckPassword(_ password:String) throws -> String {
    if password.count < 6 {
        throw PasswordError.tooshort
    }
    return "Password Accepted"
}
let result = try? CheckPassword("1234")
print(result ?? "no password")

let result1 = try? CheckPassword("123456745")
print(result1 ?? "no password")


//Using try!
//Use try! only when you are certain no error will occur.
enum MathError : Error {
    case divideByZero
}
func divide(_ a: Int, by b: Int) throws -> Int {
    if b == 0 {
        throw MathError.divideByZero
    }
    return a / b
}
let result4 = try! divide(10, by: 2)
print(result4)


//rethrows
//A function uses rethrows when it only throws an error if the closure passed to it throws.
func perform(_ action:() throws -> Void)rethrows{
    try action()
}
do{
    try perform {
        print("Running")
    }
}catch{
    print("Error")
}

/*
 | Keyword    | Purpose                                           |
 | ---------- | ------------------------------------------------- |
 | `Error`    | Defines a custom error type                       |
 | `throws`   | Marks a function that can throw an error          |
 | `throw`    | Throws an error                                   |
 | `try`      | Calls a throwing function                         |
 | `do-catch` | Handles errors                                    |
 | `try?`     | Returns `nil` if an error occurs                  |
 | `try!`     | Assumes no error will occur (crashes if one does) |
 | `rethrows` | Throws only if a passed-in closure throws         |
*/

//
struct Item {
    var price: Int
    var count: Int
}

enum VendingMachineError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}

class VendingMachine {
    var inventory = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11)
    ]
    var coinsDeposited = 0
    func vend(itemNamed name: String) throws {
        guard let item = inventory[name] else {
            throw VendingMachineError.invalidSelection
        }
        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }
        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }
        coinsDeposited -= item.price
                var newItem = item
                newItem.count -= 1
                inventory[name] = newItem
                print("Dispensing \(name)")
            }
        }
let favoriteSnacks = [
    "Alice": "Chips",
    "Bob": "Licorice",
    "Eve": "Pretzels",
]
func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    try vendingMachine.vend(itemNamed: snackName)
}
struct PurchasedSnack {
    let name: String
    init(name: String, vendingMachine: VendingMachine) throws {
        try vendingMachine.vend(itemNamed: name)
        self.name = name
    }
}
var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 7
do {
    try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
    print("Success! Yum.")
} catch VendingMachineError.invalidSelection {
    print("Invalid Selection.")
} catch VendingMachineError.outOfStock {
    print("Out of Stock.")
} catch VendingMachineError.insufficientFunds(let coinsNeeded) {
    print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
} catch {
    print("Unexpected error: \(error).")
}


//defer in Swift
//defer is used to delay the execution of a block of code until the current scope exits.
func greet() {
    defer {
        print("Goodbye")
    }
    print("Hello")
}
greet() //first we get the hello and then  prints the good bye because the defer keyword


//defer with return
func test() -> Int {
    defer {
        print("defer with return test")
    }
    print("defer with return it is running")
    return 100
}
print(test())


//Multiple defer Blocks
//defer blocks execute in reverse order (Last In, First Out - LIFO).
func demo() {
    defer {
        print("1")
    }
    defer {
        print("2")
    }
    print("3")
}
demo()


//defer with Error Handling
enum Loginnerror:Error{
    case invalidPassword
}
func Loginnig(password:String) throws {
    defer {
        print("Logged in")
    }
    if password != "1234" {
        throw Loginnerror.invalidPassword
    }
    print("Login Success")
}
do {
    try Loginnig(password:"123478")
}catch{
    print("Wrong password")
}


//Resource Cleanup
func processFile(){
    print("file opened")
    defer{
        print(" file closed")
    }
    print("file processing")
}
processFile()

//Without defer
func example(success: Bool) {
    print("Without defer Resource Opened")
    if !success {
        print("Without defer Resource Closed")
        return
    }
    print("Without defer Working")
    print("Without defer Resource Closed")
}
example(success: true)
//example(success: false)

//With defer
func example1(success: Bool) {
    print("With defer Resource Opened")
    defer {
        print("With defer Resource Closed")
    }
    if !success {
        return
    }
    print("With defer Working")
}
//example1(success: true)
example1(success: false)


//Specifying Cleanup Actions
func processData() {
    print("File Opened")

    defer {
        print("File Closed")
    }

    print("Reading data...")
    print("Processing data...")
}

processData()



import Foundation
func processData(filename: String) throws {
    if FileManager.default.fileExists(atPath: filename) {
        let text = try String(contentsOfFile: filename, encoding: .utf8)
        defer {
            print("Finished processing file.")
        }
        print(text)
    } else {
        print("File doesn't exist")
    }
}
let path = "/Users/meghanaios/study.txt"
do {
    try processData(filename: path)
} catch {
    print("Error: \(error)")
}


/*
 when we are going to use import Foundation?

 | Feature                       | Need `Foundation`? |
 | ----------------------------- | ------------------ |
 | Arrays                        | ❌ No               |
 | Dictionary                    | ❌ No               |
 | Loops                         | ❌ No               |
 | Classes/Structs               | ❌ No               |
 | Functions                     | ❌ No               |
 | `FileManager`                 | ✅ Yes              |
 | `Date`                        | ✅ Yes              |
 | `URL`                         | ✅ Yes              |
 | `JSONEncoder` / `JSONDecoder` | ✅ Yes              |
 | `String(contentsOfFile:)`     | ✅ Yes              |
 | `Timer`                       | ✅ Yes              |
*/


//Specifying the Error Type
enum StatisticsError: Error {
    case noRatings
    case invalidRating(Int)
}
func summarize(_ ratings: [Int]) throws(StatisticsError) {
    guard !ratings.isEmpty else { throw .noRatings }
    var counts = [1: 0, 2: 0, 3: 0]
    for rating in ratings {
        guard rating > 0 && rating <= 3 else { throw .invalidRating(rating) }
        counts[rating]! += 1
    }
    print("*", counts[1]!, "-- **", counts[2]!, "-- ***", counts[3]!)
}
func someThrowingfunc() throws {
    let ratings = [1,2,3,2,3,1,1,3]
    try summarize(ratings)
}

func Somthrowingfunc() throws(any Error) {
    let ratings = [1,2,3,2,3,1,1,3]
    try summarize(ratings)
}
func nonThrowingfunc() throws(Never){
    let ratings = [1,2,3,2,3,1,1,3]
    print(ratings)
}
let ratings1: [Int] = []
do throws(StatisticsError) {
    try summarize(ratings1)
} catch {
    switch error {
    case .noRatings:
        print("No ratings")
    case .invalidRating(let rating):
        print("Invalid rating: \(rating)")
    }
}
