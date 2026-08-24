import UIKit

//creating Structs
struct sports{
    var name : String
}
var cricket = sports(name: "cricket")
print(cricket)

cricket.name = "cricket1"


struct user{
    let name : String
    let age : Int
    let city : String
}
func authenticate(_ userr: user){
    print("authenticated")
}
func showPrfile(for userr: (name: String, age: Int, city: String)){
    print("show profile")
}
func signOut(_ userr: user){
    print("signed out")
}


//Computed properties
struct sportss{
    var name : String
    var isolympicspot : Bool
    
    var olympicstatus: String{
        if isolympicspot{
            return "true"
        }else{
            return "false"
        }
    }
}
let chessBoxing = sportss(name: "chessboxing", isolympicspot: true)

print(chessBoxing.olympicstatus)

//Property observers
struct pro{
    var task : String
    var amount : Int
}
var task = pro(task: "study", amount: 10)
task.amount = 100
task.amount = 200
print(task)
//difference between struct and class
/*| Struct                                                                                     | Class                                          |
| ------------------------------------------------------------------------------------------ | ---------------------------------------------- |
| Value type                                                                                 | Reference type                                 |
| Stored directly (typically on the stack or inline in another object)                       | Stored on the heap, variable holds a reference |
| Copied by value                                                                            | Copied by reference                            |
| Cannot inherit from another struct or class                                                | Supports inheritance                           |
| Good for small, immutable data                                                             | Good for complex objects with behavior         |
| Cannot have a parameterless constructor (before C# 10; now allowed with some restrictions) | Can have any constructors                      |*/

//didset is used for to show the update value

struct Resolution {
    var width = 0
    var height = 0
}
class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

//class override
class hi{
    var a = 10
     func test(){
        print(a)
    }
}
class hello : hi{
    override func test() {
        print("hello \(a)")
    }
}
let aa = hello()
aa.test()


//struct override - is not possible
struct A {
    var a: Int
}
var a = A(a: 10)
a.a = 100
print(a)

struct B {
    var a: Int
}
//class S : B{}   //inheritance is not possible in struct


//class deinit
class Person {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is initialized")
    }
    deinit {
        print("\(name) is deinitialized")
    }
}
var person: Person? = Person(name: "Meghana")
person = nil


//struct deinit -is not possible
struct person1{
    let names : String
    init(names: String) {
        self.names = names
        print("\(names)in initialized")
    }
//    deinit {
//        print("\(names)is deinitialized")
//    }
}   //deinit in struct is not possible


//class arc
class Person1{
    let name:String
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}

var reference1 : Person1?
var reference2 : Person1?
var reference3 : Person1?

reference1 = Person1(name: "Meghana")
reference2 = Person1(name: "Yashu")
reference3 = Person1(name: "hruthik")

reference1 = nil
reference2 = nil
reference3 = nil


//struct arc -is not possible
struct Person2{
    let name:String
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    //    deinit {
    //        print("\(name) is being deinitialized")
    //    }
    //}
    //
    //var reference1 : Person2?
    //var reference2 : Person2?
    //var reference3 : Person2?
    //
    //reference1 = Person2(name: "Meghana")
    //reference2 = Person2(name: "Yashu")
    //reference3 = Person2(name: "hruthik")
    //
    //reference1 = nil
    //reference2 = nil
    //reference3 = nil
}


//class
class Person3 {
    var name: String
    init(name: String) {
        self.name = name
    }
}
let person5 = Person3(name: "Meghana")
let person6 = person5
let person7 = Person3(name: "Meghana")
print(person5 === person7)   // false
print(person5 === person6)   // true


class Person4: Equatable {
    var name: String
    init(name: String) {
        self.name = name
    }
    static func == (lhs: Person4, rhs: Person4) -> Bool {
        lhs.name == rhs.name
    }
}
let p1 = Person4(name: "Meghana")
let p2 = Person4(name: "Meghana")
print(p1 == p2)    // true (same values)
print(p1 === p2)   // false (different objects)


//static keyword
//The static keyword in Swift is used to create type properties and type methods. These belong to the type itself, not to individual objects (instances).

/*when we want to use static?
 Use static when the value is common to every instance and doesn't need to be duplicated.*/


//instance property
struct student{
    var name:String
}
let s1 = student(name: "meghana")
let s2 = student(name: "ajay")
print(s1.name)
print(s2.name)

//Static property
struct Student {
    static let school = "ABC School"
    var name: String
}
print(Student.school)


struct Person5 {
    var aaa = 19
    static func ass(){
        let h = 88
        //print(aaa)
        print(h)
    }
}

struct student0{
    static let school = "abc school"
    var name:String
}
let d = student0(name: "meghana")
let f = student0(name: "nandini")
print(student0.school)
//student0.school = "xyz school" error because of let keyword

//counting property
//One of the most common uses of static properties is counting how many objects are created.
//class Employee {
//    static var totalEmployees = 0
//    var name: String
//    init(name: String) {
//        self.name = name
//        Employee.totalEmployees += 1
//    }
//}
//let e1 = Employee(name: "Meghana")
//let e2 = Employee(name: "Ajay")
//let e3 = Employee(name: "Anu")
//print(Employee.totalEmployees)


