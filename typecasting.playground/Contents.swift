import UIKit

//Create a Base Class
class vehicle{
    var name :String
    init(name: String) {
        self.name = name
    }
}
class car:vehicle{
    var no :Int
    init(no: Int,name: String) {
        self.no = no
        super.init(name : name)
    }
}
class bike:vehicle{
    var hasGear :Bool
    init(hasGear: Bool,name: String) {
        self.hasGear = hasGear
        super.init(name : name)
    }
}
let v : [vehicle] = [
    car(no:4,name:"BMW"),
    bike( hasGear: true,name: "Hero"),
    car(no: 2,name: "Audi")
]
for vehicle in v {
    if vehicle is car{
        print("This is a car")
    }else if vehicle is bike{
        print("it is bike")
    }
}

//Downcasting
for vehicle in v {
    if let car = vehicle as? car{
        print("This is a car\(car.name),no of doors are \(car.no)")
    }
}
let mycar = v[0] as! car
print(mycar.no)

//Count Object Types or Checking Type
var carCount = 0
var bikeCount = 0
for vehicle in v {
    if vehicle is car{
        carCount += 1
    }else if vehicle is bike{
        bikeCount += 1
    }
}
print("Number of cars \(carCount) and bikes \(bikeCount)")


//Type Casting for Any and AnyObject
var things: [Any] = []
things.append(0)
things.append(0.0)
things.append(42)
things.append(3.14159)
let optionalNumber: Int? = 3
things.append(optionalNumber)        // Warning
things.append(optionalNumber as Any) // No warning
