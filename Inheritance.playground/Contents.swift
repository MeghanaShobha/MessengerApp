import UIKit

//Initializers
//Initializers are called to create a new instance of a particular type

struct Fahrenheit {
    var temperature: Double
    init() {
        temperature = 32.0
    }
}
var f = Fahrenheit()
print("the default temperature is \(f.temperature)")


struct Celsius{
    var tempInCelsius: Double
    init(Fromfahrenheit fahrenheit:Double){
        tempInCelsius = (fahrenheit - 32.0) / 1.2
    }
    init (Fromkelvin kelvin:Double){
        tempInCelsius = kelvin - 273.15
    }
}
let bioling = Celsius(Fromfahrenheit: 152.0)
let b = bioling.tempInCelsius
print(b)
let freezing = Celsius(Fromkelvin: 273.15)
let k = freezing.tempInCelsius
print(k)


//Parameter Names and Argument Labels
struct color{
    let red,green,blue:Double
    init(red:Double,green:Double,blue:Double){
        self.red = red
        self.green = green
        self.blue = blue
    }
    init(white:Double){
        self.red = white
        self.green = white
        self.blue = white
    }
}
let m = color(red: 0.8, green: 0.2, blue: 0.3)
print(m)


//Initializer Parameters Without Argument Labels
struct Celsius1{
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    init(_ celsius: Double) {
        temperatureInCelsius = celsius
    }
}
let bodyTemperature = Celsius1(37.0)
let aa = bodyTemperature.temperatureInCelsius //is 37.0
print(aa)


//?? is the nil-coalescing operator.
class Vehicle{
    var numberOfWheels = 0
    var description :String{
        return "\(numberOfWheels)-wheels"
    }
}
class Car : Vehicle{
    override var description :String {
        return "\(super.description) in car"
    }
}

let car = Car()
car.numberOfWheels = 4
print(car.description)

//Optional Property Types
class serveyQuestions{
    var text:String
    var response:String?
    init(text:String){
        self.text = text
    }
    func ask(){
        print(text)
    }
}
let question = serveyQuestions(text: "Your favourite programming language?")
question.ask()
question.response = "Swift"

//Default Initializers
class Vehicle1{
    var numberOfWheels = 4
}
class Car1 : Vehicle1{
    var hasBasket = true
}
let carr = Car1()
print(carr.numberOfWheels)

//Memberwise Initializers for Structure Types - A memberwise initializer is an initializer Swift automatically provides for a struct. It lets you create the struct by giving values for its stored properties.
struct Size {
    var width = 0.0, height = 0.0
}
let twoByTwo = Size(width: 2.0, height: 2.0)

//Initializer delegation means one initializer calls another initializer of the same type to avoid repeating setup code.
struct Size1 {
    var width: Double
    var height: Double
    init(width: Double, height: Double) {
        self.width = width
        self.height = height
    }
    init(square side: Double) {
        self.init(width: side, height: side)
    }
}


//class
//Designated Initializers and Convenience Initializers
//syntax
/*
 init(parameters) {
 statements
}
 */

// convenience initializers

/*
 convenience init(parameters) {
 statements
}
 */
/*Designated initializer: the main initializer that fully initializes the class’s own properties, then calls a parent initializer with super.init(...).
 
 Convenience initializer: a helper initializer that calls another initializer in the same class with self.init(...).*/


//Initializer Delegation for Class Types
//rules
/*
 Rule 1
 A designated initializer must call a designated initializer from its immediate superclass.

 Rule 2
 A convenience initializer must call another initializer from the same class.

 Rule 3
 A convenience initializer must ultimately call a designated initializer.*/

class Vehicle2 {
    var numberOfWheels: Int
    init() {
        self.numberOfWheels = 0
    }
}
class bicycle : Vehicle2 {
    override init() {
        super.init()
        self.numberOfWheels = 2
    }
}
let bb = bicycle()
print(bb.numberOfWheels)


//designated initializer - it is the main initialization ,it initializers the class owns properties,then it go to the parent properties
class product1{
    var name: String
    var quantity:Int = 0
    init(name: String) {
        self.name = name
    }
}
class product : product1{
    init (name: String, quantity : Int ){
        super.init(name:name)
        self.quantity = quantity
    }
}

//convenience initializers - it calls the another initializers in the same class using self.init(...)

class Product {
    var name: String
    var quantity: Int
    init(name: String, quantity: Int) {
        self.name = name                        // Designated initializer
        self.quantity = quantity
    }
    convenience init(name: String) {             // Convenience initializer
        self.init(name: name, quantity: 1)
    }
}

//failable initializer - it can return nil when it cannot create a vaild object
struct Student{
    let age:Int
    init?(age:Int){
        guard age >= 0 else{return nil}
        self.age=age
    }
}
let valid = Student(age: 20)
print(valid ?? 0)
let invalid = Student(age: -1)
print(invalid ?? "invalid age")


//Overriding a Failable Initializer
class Document{
    var name:String?
    init(){}
    init?(name:String){
        if name.isEmpty{return nil}
        self.name = name
    }
}
class AutoMate:Document{
    override init() {
        super.init()
        self.name = "[untitled]"
    }
    override init(name:String){
        super.init()
        if name.isEmpty{
            self.name = "[Untitled]"
        }else{
            self.name = name
        }
    }
}
class UntitledDocument:Document {
    override init() {
        super.init(name: "[Untitled]")!
    }
}

//Required Initializers
/*A required initializer forces every subclass to provide that initializer.
Use required when every child class must be able to initialize itself in a particular way.*/

class product2{
    var name:String
    required init(name:String){
        self.name = name
    }
}
class Foodproduct : product2{
    var shelfLife:String
    required init(name:String){
        self.shelfLife = "NotSet"
        super.init(name: name)
    }
}
let item = Foodproduct(name:"Milk")
print(item.name)

//Setting a Default Property Value with a Closure or Function
class Product3 {
    var prices: [Int] = {
        let firstPrice = 10
        let secondPrice = 20
        return [firstPrice, secondPrice]
    }()
}
let product4 = Product3()
print(product4.prices) 
