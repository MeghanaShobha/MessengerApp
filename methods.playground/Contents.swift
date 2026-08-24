import UIKit

//differnce between function and method

/*  function - it is a reusable block of code
    method - it is function that belongs to the class,struct or enum */

//function
func greet(){
    print("hello")
}
let greetobj: () = greet()
print(greetobj)

//method
class greetClass{
    func greet(){
        print("hello siddu")
    }
}
let greetObject = greetClass()
greetObject.greet()



class counter{
    var count = 0
    func increment(){
        count += 1
    }
    func increment(by amount: Int){
        count += amount
    }
    func reset(){
        count = 0
    }
}
let counterObject = counter()
counterObject.increment()
counterObject.increment(by: 5)
counterObject.reset()


//self
//Every instance of a type has an implicit property called self,which is exactly equivalent to the instance itself.

//func increment(){
//    self.count += 1
//}


class phone{
    var model = "iphone"
    func showModel(){
        print(self.model)  //model property of the phone object
    }
}
var Phone = phone()
Phone.showModel()


class phone1{
    var model: String
    init(model: String) {
        self.model = model //property of the object being created
    }
}
var Phone1 = phone1(model: "Samsung")
print(Phone1.model)

struct Counter{
    var count = 0
    mutating func increment(){
        count += 1
    }
}
var counterObject1 = Counter()
counterObject1.increment()
print(counterObject1.count)


struct point{
    var x = 0.0 , y = 0.0
    func Istotherightof(x:Double)->Bool{
        return self.x > x
    }
}
let somepoint = point(x: 14.0, y: 7.0)
if somepoint.Istotherightof(x: 1.0){
    print("this point is right of the line")
}

//Modifying Value Types from Within Instance Methods
struct Point{
    var x: Double, y: Double
    mutating func scaleInPlace(by factor: Double){
        self.x *= factor
        self.y *= factor
    }
}
var a = Point(x: 8.0, y: 8.0)
a.scaleInPlace(by: 2.0)
print(a)

//Assigning to self Within a Mutating Method
struct point1{
    var x: Double, y: Double
    mutating func scaleInPlace(by factor: Double){
        self = point1(x: self.x * factor, y: self.y * factor)
    }
}


enum TriStateSwitch{
    case off, low, high
    mutating func next(){
        switch self{
            case .off:
            self = .low
        case .low:
            self = .high
        case .high:
            self = .off
        }
    }
    
}
var overLight = TriStateSwitch.low
overLight.next()
print(overLight)
overLight.next()
print(overLight)


//Type Methods
class subclass{
    class func subClassMethod(){
        print("this is a subclass method")
    }
}
subclass.subClassMethod()


//struct levelTracker{
//    static var highestUnlockedLevel = 1
//    var currentLevel = 1
//    
//    static func unlock(_ level: Int){
//        if level > highestUnlockedLevel{highestUnlockedLevel=level}
//    }
//    static func isUnlock(_ level:Int)->Bool{
//        return level <= highestUnlockedLevel
//    }
//    @discardableResult
//    mutating func advanceTo(to level:Int)->Bool{
//        if level > level{
//            return false
//        }else{
//            currentLevel = level
//            return true
//        }
//    }
//}
//
//class Player {
//    var tracker = levelTracker()
//    let playerName: String
//    func complete(level: Int) {
//        levelTracker.unlock(level + 1)
//        tracker.advanceTo(to: level + 1)
//    }
//    init(name: String) {
//        playerName = name
//    }
//}
