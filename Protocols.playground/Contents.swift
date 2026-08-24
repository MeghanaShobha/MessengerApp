import UIKit

//Protocol - A protocol defines a blueprint of methods, properties, and other requirements that a class, structure, or enumeration must implement.

//Method Requirement
protocol Animal{
    func makeSound()
}
struct Dog:Animal{
    func makeSound() {
        print("Woof!")
    }
}
let dog = Dog()
dog.makeSound()

//Property Requirement
protocol person{
    var name:String{get}
}
struct Student : person{
    var name:String
}
let student = Student(name:"Meghana")
print(student.name)


//Multiple Requirements

protocol Employee{
    var name:String{get}
    func work()
}
struct Developer : Employee{
    var name: String
    func work() {
        print("\(name) is Coding")
    }
}
let dev = Developer(name: "Meghana")
dev.work()


 //Protocol Inheritance
//One protocol can inherit from another.
protocol livingThing{
    func breathe()
}
protocol Animal1 : livingThing{
    func eat()
}
struct Cat : Animal1{
    func breathe() {
        print("Breathing")
    }
    func eat() {
        print("Eating")
    }
}

//Protocol Composition
//A function can require multiple protocols.

protocol greetable{
    func greet()
}
struct Teacher:greetable{
    func greet() {
        print("Hello")
    }
}
func welcome(_ person:greetable){
    person.greet()
}
welcome(Teacher())


//Mutating Methods
//If a protocol method changes a struct or enum, mark it as mutating.
protocol Switchable{
    mutating func toggle()
}
enum Light : Switchable{
    case on , off
    mutating func toggle() {
        self = (self == .on) ? .off : .on
    }
}



//Protocol Extensions
//You can provide default implementations.
protocol Greeting{
    func sayHello()
}
extension Greeting{
    func sayHello(){
        print("meghana")
    }
}
struct User : Greeting{}
let user = User()
user.sayHello()

//Class-Only Protocols
//Restrict a protocol so only classes can adopt it.
protocol manager : AnyObject{
    func manage()
}
class TeamLead: manager{
    func manage() {
        print("Managing team")
    }
}


//opaque and boxed protocol types
//opaquetype(some)
protocol vehicle{
    func drive()
}
struct Car : vehicle{
    func drive() {
        print("car")
    }
}
struct Bike : vehicle{
    func drive() {
        print("bike")
    }
}



//Delegation
protocol HomeworkDelegation {
    func HomeworkCompleted()
}
class Student1{
    var delegate : HomeworkDelegation?
    func doHomeWork(){
        print("Student is doing homework")
        delegate?.HomeworkCompleted()
    }
}
class Teacher1 :HomeworkDelegation{
    func HomeworkCompleted() {
        print("good job home work is completed")
    }
}
let student1 = Student1()
let teacher = Teacher1()
student1.delegate = teacher
student1.doHomeWork()




//Conditionally Conforming to a Protocol
protocol printable{
    func printValue()
}
class Student5 : printable{
    let name:String
    init(name: String) {
            self.name = name
        }
    func printValue() {
        print(name)
    }
}
extension Array:printable where Element : printable{
    func printValue() {
        for element in self{
            element.printValue()
        }
    }
}
let students2 = [
    Student5(name: "Alice"),
    Student5(name: "Bob")
]
students2.printValue()


//Adopting a Protocol Using a Synthesized Implementation
struct type : Equatable {
    let name: String
    let age: Int
    
    static func == (lhs: type, rhs: type) -> Bool {
        return lhs.name == rhs.name &&
        lhs.age == rhs.age
    }
}
let s1 = type(name: "Alice", age: 20)
let s2 = type(name: "Alice", age: 20)
print(s1 == s2)


@available(*, deprecated)
func oldMethod() {
    print("Old Method")
}


//Checking for Protocol Conformance
//is
protocol Animal2 {
    func makesound()
}
struct Dog1:Animal2{
    func makesound() {
        print("woof")
    }
}
struct Car1 {}
let dog1 = Dog1()
let car1 = Car()
print(dog1 is Animal2)
print(car1 is Animal2)



//as?
let dog2 = Dog1()
if let animal = dog2 as? Animal2 {
    animal.makesound()
}


//optional protocol requirements
protocol Animal4{
    func eat()
    func sleep()
}
class Dog2 : Animal4{
    func eat(){
        print("Eating")
    }
    func sleep(){
        print("Sleep")
    }
}


// @objc - before the protocol
//optional - before the methods


@objc protocol ButtonDelegate{
    @objc optional func buttonpressed()
    @objc optional func buttonreleased() //required inside the init
}
class viewController: NSObject, ButtonDelegate{
    func buttonpressed() {
        print("button pressed")
    }
    func buttonreleased() {
        print("button released")
    }
}
let delegate : ButtonDelegate?=viewController()
delegate?.buttonpressed?()
delegate?.buttonreleased?()


