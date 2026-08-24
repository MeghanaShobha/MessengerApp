import UIKit

/* five types of access control
 *open
 *public
 *internal
 *fileprivate
 *private
*/

/*Think of a company:
 
 CEO's office → Only the CEO can enter (private).
 HR department → Only company employees can enter (internal).
 Reception → Anyone can enter (public).*/


/*public → Anyone can enter.
 internal → Only people inside your building can enter.
 private → Only you can enter your room.*/
/*| Access Level | Same File                         | Same Module | Other Modules               |
 | ------------ | --------------------------------- | ----------- | --------------------------- |
 | open         | ✅                                 | ✅           | ✅ (can subclass & override) |
 | public       | ✅                                 | ✅           | ✅                           |
 | internal     | ✅                                 | ✅           | ❌                           |
 | fileprivate  | ✅ (same file only)                | ❌           | ❌                           |
 | private      | Only inside declaration/extension | ❌           | ❌                           |
*/

//1. open - Used mostly when creating frameworks.
//An open class is designed to be extended by other modules.
//This is the least restrictive.
open class Animal{
    open func Speak(){
        print("Animal Sound")
    }
}

class Dog: Animal,CustomStringConvertible{
    let description: String
    
    init(description: String) {
        self.description = description
    }
    override func Speak() {
        print("Dog Sound")
    }
}



let action = Dog(description: "satyam brother")
var a:[Any] = [2,3,4,action]
print(a)
print(action)
action.Speak()

/*| Feature                               | `public`      | `open`                                         |
 | ------------------------------------- | ------------- | ---------------------------------------------- |
 | Accessible from other modules         | ✅ Yes         | ✅ Yes                                          |
 | Can be subclassed in other modules    | ❌ No          | ✅ Yes                                          |
 | Can override methods in other modules | ❌ No          | ✅ Yes                                          |
 | Used for                              | Exposing APIs | Exposing APIs that are designed to be extended |
*/


/*2. public - A public class or method can be used outside its module, but it cannot be subclassed or overridden outside that module.
 Everyone can access it.
 But another module cannot subclass or override it.*/
public class Car {
    public func start() {
        print("Started")
    }
}
let car = Car()
car.start()


/*private      -> Only me
 fileprivate  -> Only this file
 internal     -> Only this module (default)
 public       -> Everyone can use it
 open         -> Everyone can use it and inherit from it*/


//public
//public class Animal { }
//class Dog: Animal { }   // Error


//open
//open class Animal { }
//class Dog: Animal { }   // Works


//internal
/*3. internal - Anyone inside the same app/module can use it.
This is the default.
If you don't write any access modifier, Swift uses internal.*/
class Student {
    var name = "John"
    func study() {
        print("Studying")
    }
}
internal class Students {
    internal var name = "John"
    internal func study() {}
}
let student = Student()
student.name
student.study()


/*4. fileprivate
 Accessible only within the same source file, even across different types in that file.*/
class Employee{
    fileprivate var salary = 100000
}
class hr{
    func printSalary(employee:Employee) {
        print("Salary is \(employee.salary)")
    }
}
//Move HR to another file:error


/*5. private
Most restrictive.
Accessible only inside the declaration and its extensions in the same file.*/
class Teacher{
    private var age = 24
    func showage(){
        print(age)
    }
}
let teacher = Teacher()
teacher.showage()
//teacher.age //- 'age' is inaccessible due to 'private'


//AccessControl syntax
public class somepublicclass {}
internal struct someinternalstruct{}
private func somefunc(){}



//custom type
//A custom type is a type that you create yourself instead of using Swift's built-in types like Int, String, Double, or Bool.
/*Swift provides four main kinds of custom types:
        *Structure (struct)
        *Class (class)
        *Enumeration (enum)
        *Protocol (protocol)
 */

/*Tuple types don’t have a standalone definition in the way that classes, structures, enumerations, and functions do. A tuple type’s access level is determined automatically from the types that make up the tuple type, and can’t be specified explicitly.*/


/*Why do we need custom types?
 Suppose you're creating a student management app.
 
 Instead of storing student information in separate variables:
 You can group them together as one custom type.
 */

//Custom Type using Struct
struct Studentss {
    var name: String
    var age: Int
    var course: String
}
let student1 = Studentss(name:"meghana",age:24,course: "ios")
print(student1.name)
print(student1.age)
print(student1.course)


//Custom Type using Class
class Employeee:CustomStringConvertible{
    var name : String
    var salary : Int
    
    init(name: String, salary: Int) {
        self.name = name
        self.salary = salary
    }
    var description: String{
        return "Employee(Name: \(name), Salary: \(salary))"
    }
}
let emp = Employeee(name: "yashu", salary: 24)
print(emp.name)


//Custom Type using Enum
enum direction{
    case north
    case south
    case east
    case west
}

let move = direction.north
print(move)

//nested types
//The access level of a nested type is the same as its containing type, unless the containing type is public.

//Subclassing
public class A{
    fileprivate func something(){}
}
internal class B : A{
    override internal func something(){}
}
internal class C : A{
    override internal func something() {
        super.something()
    }
}
//Because superclass A and subclass C are defined in the same source file, it’s valid for the C implementation of something() to call super.something().


//getters and setters
//A getter returns the value of a property.
struct Rectangle{
    var weight: Int
    var height: Int
    
    var area: Double {
        get{
            return Double(weight * height)
        }
    }
}
let rect = Rectangle(weight: 10, height: 20)
print(rect.area)

//A setter is called when you assign a new value to a computed property.
struct square{
    var side: Int
    
    var area : Double {
        get{
            return Double(side*side)
        }
        set{
            side = Int(sqrt(newValue))}
    }
}
let sq = square(side: 12)
print(sq.area)

/*Why do we need mutating?
 By default, structs are value types, and their methods cannot modify their own properties unless you explicitly tell Swift that the method is allowed to change the instance.*/
//private(set) - everyone can see the properties but only class or struct can change the property
struct Student1{
    private(set) var marks = 0
    mutating func updateMarks() {
        marks += 10
    }
}
var s = Student1()
print(s.marks)
s.updateMarks()
print(s.marks)


//real time example
struct BankAccount{
    private(set) var balance: Int
    mutating func deposit(amount: Int) {
        balance += amount
    }
}
var account = BankAccount(balance: 3000)
account.deposit(amount: 1000)
print(account.balance)
//account.balance = 2000 //error  *Only the deposit() function can update the balance.


//What is didSet in Swift?
//didSet is a property observer. It runs immediately after a property's value has changed.
struct TrackedString{
    private(set) var numofEdits = 0
    var value = "" {
        didSet {
            numofEdits += 1
        }
    }
}
var text = TrackedString()
text.value = "Hello"
text.value = "Hi"
text.value += " "+"i am here"
print(text.numofEdits)
print(text.value)
//text.numberOfEdits = 10 // error because it is private(set)


//Initializers
//An initializer (init) creates an object.
class person{
    var name: String
    init(name: String) {
        self.name = name
    }
}
let texts = person(name: "Ajay")
print(texts.name)


//Default Initializer
//If every property has a default value, Swift creates init() automatically.
struct Student2{
    var name = "meghu"
    var age = 24
}
let ss = Student2()
print(ss.name)
print(ss.age)


//What are Stored Properties in Swift?
//A stored property is a property that stores a value directly in memory.

/*| Stored Property                      | Computed Property                          |
 | ------------------------------------ | ------------------------------------------ |
 | Stores a value in memory             | Doesn't store a value                      |
 | Has an initial value or is set later | Calculates a value when accessed           |
 | Can use `didSet` and `willSet`       | Uses `get` and optionally `set`            |
 | Example: `var age = 22`              | Example: `var isAdult: Bool { age >= 18 }` |
*/
    

//Memberwise Initializer (Structs)
//Swift automatically creates an initializer using all stored properties.

struct Employee1{
    let name: String
    let salary : Int
}
let emp1 = Employee1(name: "Ajay", salary: 100000)
print("\(emp1.name) earns \(emp1.salary)")

//Protocol Inheritance
protocol teacher1{
    func teach()
}
protocol student3 : teacher1{
    func listen()
}

struct Hruthik:student3{
    func teach(){
        print("teacher")
    }
    func listen(){
        print("student")
    }
}
let hruthik = Hruthik()
hruthik.teach()
hruthik.listen()

//Protocol Conformance
//Conformance means a class or struct follows a protocol.

protocol Animall{
    func eat()
}
struct Dogg:Animall{
    func eat(){
        print("non veg")
    }
}
let mydog = Dogg()
mydog.eat()


//Extensions
//Extensions let you add new functionality to an existing type without changing its original code.
struct person1{
    var name :String
}
extension person1{
    func greet(){
        print("hello i am \(name)")
    }
}
let n = person1(name:"Meghana")
n.greet()

//Private Members in Extensions
//If the extension is in the same file, it can access private properties.

struct student4{
    private var marks = 98
}
extension student4{
    func showmarks(){
        print(marks)
    }
}
let f = student4()
f.showmarks()



protocol someprototol{
    func something()
}
struct st{
    private var s  = 10
}
extension st:someprototol{
    func something() {
        print("something")
    }
    
    func dosomething() {
        print(s)
    }
}
let stm = st()
stm.dosomething()
