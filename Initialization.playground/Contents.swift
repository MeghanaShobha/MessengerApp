import UIKit

//Initialization
class Product{
    var name:String
    var quantity:Int
    init(name: String, quantity: Int) {
        self.name = name
        self.quantity = quantity
    }
}
let apple = Product(name: "Apple", quantity: 10)
print(apple.quantity)


//stored property default values
var quantity = 1

//custom initilization
class login{
    var name:String
    init(name: String) {
        self.name = name    //self to assign the objects property
    }
}

//Parameter name
class login1{
    var name:String
    init(name: String) {    // here name is the parameter
        self.name = name
    }
}

let n = login1(name: "Aman")


//Initializer delegation
class login2{
    var name:String
    var quantity:Int
    init(name:String,quantity:Int){
        self.name = name
        self.quantity = quantity
    }
    convenience init(name: String) {        //without Designated initializer we cant write Convenience initializer
        self.init(name: name,quantity:1)
    }
}



//Inheritance initialization
class Product1{
    var name : String
    var quantity : Int
    init(name: String, quantity: Int) {
        self.name = name
        self.quantity = quantity
    }
}
class Food:Product1{
    var isPerishable:Bool
    init(name: String, quantity: Int, isPerishable: Bool) {
        self.isPerishable = isPerishable
        super.init(name: name, quantity: quantity)
    }
}

//Failable initializers - init?
struct Student{
    let age :Int
    init?(age:Int){
        guard age >= 0 else {return nil}
        self.age = age
    }
}

//Required initializers = must and should me there
class hi{
    var name:String
    var age:Int = 0
    required init(name:String){
        self.name = name
    }
}
class hello:hi{
    required init(name:String){
        super.init(name: name)
    }
    init(name:String,age:Int){
        super.init(name:name)
        self.age = age
    }
}


//Default value with a closure
struct Student1{
    var marks : [Int] = {
        return [10,20,30,40,50]
    }()
}
let m = Student1()
print(m.marks)


//Assigning Constant Properties During Initialization
//A constant property uses let. It must be assigned a value exactly once—either when declared or inside an initializer.
class Product2{
    var id :Int
    var name:String
    init(id:Int,name:String){
        self.id = id
        self.name = name
    }
}
let product  = Product2(id:30,name:"Mango")
print(product.name)
print(product.id)


//Memberwise Initializers for Structure Types
struct Size{
    var height = 0.0 ,width = 0.0
}
let hw = Size(height: 2.3, width: 4.5)
print(hw.height)
let hws = Size(height:98.9)
print(hws.height,hws.width)
let hwss = Size(width:284.9)
print(hwss.height,hwss.width)


//Failable Initializers for Enumerations - init? with enum
enum temperatureUnit {
    case kelvin
    case celsius
    case fahrenheit
    init?(symbol: Character) {
        switch symbol {
        case "K":
            self = .kelvin
        case "C":
            self = .celsius
        case "F":
            self = .fahrenheit
        default:
            return nil
        }
    }
}
let fu = temperatureUnit(symbol: "F")
if fu != nil{
    print("Iinitialization succeeded")
}

let ukU = temperatureUnit(symbol: "U")
if ukU == nil {
    print("Initialization failed")
}


//Failable Initializers for Enumerations with Raw Values
enum TemperatureUnit: Character {
    case kelvin = "K", celsius = "C", fahrenheit = "F"
}
let fu1 = TemperatureUnit(rawValue: "F")
if fu1 != nil{
    print("Iitialization succeeded")
}
let ukU1 = TemperatureUnit(rawValue: "U")
if ukU1 == nil {
    print("Initialization failed")
}


//Overriding a Failable Initializer
class Document {
    var name: String?
    init() {}
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}

//init?  → may fail; result is Optional
//init!  → may fail; result is implicitly unwrapped Optional


//Setting a Default Property Value with a Closure or Function
struct Chessboard{
    let boardColors: [Bool] = {
        var temporaryBoard: [Bool] = []
        var isBlack = false
        for i in 1...8{
            for j in 1...8{
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        return temporaryBoard
    }()
    func squareIsBlackAt(row:Int,column:Int) ->Bool{
        return boardColors[(row * 8) + column]
    }
}

let board = Chessboard()
print(board.squareIsBlackAt(row: 1, column: 6))



//Deinitializers in Action
//class Bank{
//    static var coins = 100
//    static func give(_ amount:Int)->Int{
//        let given = min(amount,coins)
//        coins -= given
//        return given
//    }
//    static func receive(_ amount:Int){
//        coins += amount
//    }
//}
//class player{
//    var coins1:Int
//    init(requestedcoins1: Int) {
//        self.coins1 = Bank.give(requestedcoins1)
//    }
//    deinit{
//        Bank.receive(coins1)
//    }
//}
//var Player:player? = player(requestedcoins1: 50)
//print(Bank.coins)
//
//Player = nil
//print(Bank.coins)
