import UIKit

//ARC means Automatic reference counting
//to track and manage your app’s memory usage. or ARC (Automatic Reference Counting) is Swift's memory management system.

/*Create memory when an object is created.
 Keep the object in memory while it is being used.
 Free the memory when the object is no longer needed.*/

//ARC works only for classes.
//It does not work for struct or enum because they are value types.

/*What is a Reference Count?
 Every class object has a count of how many variables are pointing to it.*/

/*init (initializer) → Called when an object is created.
 deinit (deinitializer) → Called just before an object is removed from memory.*/

class Person{
    let name:String
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}

var reference1 : Person?
var reference2 : Person?
var reference3 : Person?

reference1 = Person(name: "Meghana")
reference2 = Person(name: "Yashu")
reference3 = Person(name: "hruthik")

//reference1 = nil
//reference2 = nil
//reference3 = nil

reference2 = reference1
reference1 = reference3


class person{
    let name:String
    init(name: String) {self.name = name}
    var apartment: Apartment?
    deinit {print("\(name) is being deinitialized")}
}

class Apartment{
    let unit:String
    init(unit: String) {self.unit = unit}
    var tenant: person?
    deinit {print("Apartment \(unit) is being deinitialized")}
}

var john:person?
var unit4A:Apartment?

john=person(name: "john")
unit4A=Apartment(unit: "6A")

john!.apartment = unit4A
unit4A!.tenant = john

//john = nil
//unit4A = nil


class Customer{
    let name:String
    var card:CreditCard?
    init(name: String) {
        self.name = name
    }
    deinit {print("\(name) is being deinitialized")}
}

class CreditCard{
    let number:UInt64
    unowned let customer: Customer
    init(number: UInt64,customer: Customer) {
        self.number = number
        self.customer = customer
    }
    deinit {print("Card #\(number) is being deinitialized")}
}
var johns : Customer?
johns = Customer(name: "John")
johns!.card = CreditCard(number: 123456, customer: johns!)

johns = nil

/*| Feature                           | `weak`                              | `unowned`                                 |
 | --------------------------------- | ----------------------------------- | ----------------------------------------- |
 | Can become `nil`?                 | ✅ Yes                               | ❌ No                                      |
 | Must be optional?                 | ✅ Yes (`Person?`)                   | ❌ No (`Person`)                           |
 | Automatically set to `nil`?       | ✅ Yes                               | ❌ No                                      |
 | Crashes if object is deallocated? | ❌ No                                | ✅ Yes (runtime crash)                     |
 | Use when                          | The referenced object may disappear | The referenced object should always exist |
*/


class Department{
    var name : String
    var course : [Course]
    init(name: String) {
        self.name = name
        self.course = []
    }
}
class Course{
    var name : String
    unowned var department: Department
    unowned var nextCourse: Course?
    init(name: String,in department: Department) {
        self.name = name
        self.department = department
        self.nextCourse = nil
    }
}
let department = Department(name: "Horticulture")
let intro = Course(name: "Survey of Plants", in: department)
let intermediate = Course(name: "Growing Common Herbs", in: department)
let advanced = Course(name: "Caring for Tropical Plants", in: department)
intro.nextCourse = intermediate
intermediate.nextCourse = advanced
department.course = [intro,intermediate,advanced]
print(department)
print(department.course)
let courses = [intro, intermediate, advanced]
for course1 in courses {
    print("\(course1.name) (\(course1.department.name))")
}
print(courses[0].name)


class Country{
    let name: String
    var captialCity: City!
    init(name: String, captialName:String) {
        self.name = name
        self.captialCity = City(name: captialName, country: self)
    }
}
class City{
    let name:String
    unowned var country: Country
    init(name: String, country: Country) {
        self.name = name
        self.country = country
    }
}

var country = Country(name: "Canada", captialName: "Ottawa")
print("\(country.name)'s capital city is called \(country.captialCity.name)")
print(country.name)
print(country.captialCity.name)


//What is lazy?
//A lazy property is not created immediately.
class HTMLElement{
    let name:String
    let text:String?
    
    lazy var ashtml: () -> String = {
        if let text = self.text {
            return "<\(self.name)>\(self.text ?? "")</\(self.name)>"
        }else{
            return "<\(self.name) />"
        }
    }
    init(name: String, text: String?) {
        self.name = name
        self.text = text
    }
    deinit{
        print("\(name) is being deinitialized")
    }
}
let heading = HTMLElement(name: "h1", text: "Hello, world!")
let defaultText = "some default text"
heading.ashtml = {
    return "<\(heading.name)>\(heading.text ?? defaultText)</\(heading.name)>"
}
print(heading.ashtml())



class Employee {
    var name = "Meghana"
    weak var manager: Manager?

    lazy var greet: (String) -> String = {
        [unowned self, weak manager = self.manager]
        (message: String) -> String in

        let managerName = manager?.name ?? "No Manager"
        return "\(message), I am \(self.name). Manager: \(managerName)"
    }
}

class Manager {
    var name: String
    init(name: String) {
        self.name = name
    }
}

let manager = Manager(name: "setu")
let employee = Employee()
employee.manager = manager

print(employee.greet("Hello"))
