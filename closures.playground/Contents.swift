import UIKit

//Closure Expressions:
//Closure expressions are a concise way to define unnamed closures. They are written in a lightweight syntax and are commonly used for simple, single-expression functions.


let numbers = [1, 2, 3, 4, 5]
let squared = numbers.map { $0 * $0 }
print(squared)


//Trailing Closures:
//Trailing closures allow you to write clean and readable code by placing the closure outside the function call’s parentheses.
performOperation(operation: {
    print("hello")
})
func performOperation(operation: () -> Void) {
    print("Before operation")
    operation()
    print("After operation")
}


func makeSquareof(digit:Int,onCompletion:(Int)->Void){
    let squareDigit = digit*digit
    onCompletion(squareDigit)
}
makeSquareof(digit: 5, onCompletion: { (result) in
    print(result)
})
             
func makeSquare(digit:Int,onCompletion:(Int)->Void){
    let squareDigit = digit*digit
    onCompletion(squareDigit)
    makeSquare(digit:9){ squareDigit in
        print("Square of 9 is \(squareDigit)")
    }
}
    
    func makeIncrement(forIncrement amount: Int) -> () -> Int {
        var runningTotal  = 0
        func incrementer() -> Int{
            runningTotal += amount
            return runningTotal
        }
        return incrementer
    }
    
    
    func greet(name:String,action:()-> Void){
        print("hello \(name)")
        action()
    }
    //normal
    greet(name:"meghana",action: {
        print("welcome")
    })
    //triling
    greet(name:"meghana"){
        print("welcome")
    }
        

let digitNames = [
    0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
let numbers1 = [16, 58, 510]
let strings = numbers.map { (number) -> String in
    var number = number
    var output = ""
    repeat {
        output = digitNames[number % 10]! + output
        number /= 10
    } while number > 0
    return output
}


struct Server {
    let name: String
}
struct Picture {
    let fileName: String
}
func download(_ fileName: String, from server: Server) -> Picture? {
    print("Downloading \(fileName) from \(server.name)...")
    return Picture(fileName: fileName)
}
func loadPicture(
    from server: Server,
    completion: (Picture) -> Void,
    onFailure: () -> Void
) {
    if let picture = download("photos.jpg", from: server) {
        completion(picture)
    } else {
        onFailure()
    }
}
let server = Server(name: "Apple Server")
loadPicture(from: server) { picture in
    print("Successfully loaded: \(picture.fileName)")
} onFailure: {
    print("Failed to load picture")
}

//Capturing Values
/*
 A closure can capture and store references to variables and constants from the surrounding context. Even after the surrounding function has finished executing, the closure can still access and modify those captured values.
 */


func makeCounter() -> () -> Int{
    var count = 0
    return {
        count += 1
        return count
    }
}
let counter = makeCounter()
print(counter())
print(counter())
print(counter())

func bankAccount() -> () -> Void {
    var balance = 1000
    let owner = "Meghana"

    return {
        balance += 500
        print("\(owner)'s balance: \(balance)")
    }
}
let deposit = bankAccount()
deposit()
deposit()
deposit()

//Each Closure Has Its Own Captured Values
func makeCounter1() -> () -> Int {
    var count = 0
    return {
        count += 1
        return count
    }
}
let counter1 = makeCounter1()
let counter2 = makeCounter1()
print(counter1())
print(counter1())
print(counter2())
print(counter2())

//Capturing Reference Types
class User {
    var name = "Meghana"
}
let user = User()
let closure = {
    print(user.name)
}
user.name = "Swift"
closure()


/*In Swift, closures are non-escaping by default, meaning they are executed within the scope of the function that takes them as a parameter. However, there are situations where you need a closure to outlive the function that received it. In such cases, you use the @escaping attribute to declare an escaping closure.*/

//Escaping Closures:
//var completionHandler: [() -> Void] = []
//func save(completion: @escaping () -> Void) {
//    completionHandler.append(completion)
//}
//save {
//    print("Saved!")
//}
//completionHandler.first?()


//Non escaping closures
func performOperation(completion:()-> Void)
{   print("Before")
    completion()
    print("After")
}
performOperation(completion: {
    print("Operation completed")
})



//Autoclosures in Swift
//An autoclosure is a closure that Swift creates automatically from an expression you pass to a function.
//{
//    print("hello")
//}
print("hello")


//Normal Closure
func greet (message: () -> String){
    print(message())
}
greet(message: {
    return "Hello"
})

/*@autoclosure is a function parameter attribute in Swift that automatically wraps an expression in a closure. This lets you pass an expression instead of writing an explicit closure.*/

func greet(message: @autoclosure () -> String){
    print(message())
}
greet(message: "hello")


//real time example

func expensiveCalculation() -> Int {
    print("Calculating...")
    return 100
}
//without autoclosure
func display(value: Int){
    print("Value = \(value)")
}
display(value: expensiveCalculation())


//With an autoclosure:
func display1(value: @autoclosure () -> Int) {
    print("Inside function")
    print(value())
}
display1(value: expensiveCalculation())


//Escaping Autoclosures
//Autoclosures can also be marked as @escaping if you want to store them for later.
//var c:[()-> String] = []
//func cc(_ p : @escaping @autoclosure() -> String){
//    c.append(p)
//}
//var cs = ["chris","Alex","Ewa"]
//cc(cs.remove(at: 0))
//print(cs)


/*
 | Closure                                     | Autoclosure                                          |
 | ------------------------------------------- | ---------------------------------------------------- |
 | Written explicitly using `{}`.              | Created automatically by Swift from an expression.   |
 | Caller writes the closure.                  | Caller writes a normal expression.                   |
 | Can take parameters.                        | Cannot take explicit parameters.                     |
 | Useful for callbacks and asynchronous work. | Useful for delaying evaluation and simplifying APIs. |
*/


/*
 | Feature     | Closure                    | Escaping Closure                                                 | Autoclosure                                               |
 | ----------- | -------------------------- | ---------------------------------------------------------------- | --------------------------------------------------------- |
 | What is it? | A block of reusable code.  | A closure that is stored or executed after the function returns. | A closure Swift creates automatically from an expression. |
 | Syntax      | `{ ... }`                  | `@escaping`                                                      | `@autoclosure`                                            |
 | Executed    | When called.               | Usually later.                                                   | When the function calls it.                               |
 | Common use  | `map`, `filter`, callbacks | Network requests, completion handlers                            | `assert()`, `precondition()`                              |
*/



/*NSObject is the root class of most Objective-C class hierarchies. In Swift, it is the base class for many APIs in the Apple frameworks (such as Foundation and UIKit) and provides common functionality like object identity, runtime support, and interoperability with Objective-C.*/
import Foundation
class captureList: NSObject {
    let digit = 5
    override init() {
        super.init()
        makeSquareOfValue {[digit] squareDigit in
            print("square of \(digit) is \(squareDigit)")
            
        }
    }
    func makeSquareOfValue(onCompletion: (Int) -> Void) {
            let squareDigit = digit * digit
            onCompletion(squareDigit)
    }
}
captureList()




func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}




var completionHandlers: [() -> Void] = []
@MainActor func someFunctionWithEscapingClosure(completion: @escaping () -> Void) {
    completionHandlers.append(completion)
}
func someFunctionWithNonescapingClosure(closure: () -> Void) {
    closure()
}
class SomeClass {
    var x = 10
    @MainActor func doSomething() {
        // Escaping closure
        someFunctionWithEscapingClosure {
            self.x = 100
        }

        // Non-escaping closure
        someFunctionWithNonescapingClosure {
            x = 200
        }
    }
}
let instance = SomeClass()
instance.doSomething()
print(instance.x)
completionHandlers.first?()
print(instance.x)

