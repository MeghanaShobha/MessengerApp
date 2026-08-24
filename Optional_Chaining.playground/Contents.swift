import UIKit


//Optional Chaining as an Alternative to Forced Unwrapping
class Person{
    var residence: Residence?
}
class Residence{
    var roomNumbers = 1
}
let john = Person()
//let roomcount = john.residence!.roomNumbers  //runtime error

if let roomcount = john.residence?.roomNumbers{
    print("john as \(roomcount)")
}else{
    print("unable to retrive the no of rooms")
}
 

john.residence = Residence()
if let roomcount = john.residence?.roomNumbers{
    print("john as \(roomcount)")
}else{
    print("unable to retrive the no of rooms")
}


//Defining Model Classes for Optional Chaining
class Room {
    var name: String
    init(name: String) {
        self.name = name
    }
}
class Address {
    var street: String?
}
class Person1 {
    var residence: Residence?
}
class Residence1 {
    var rooms: [Room] = []
    var numberOfRooms: Int {
        return rooms.count
    }
    subscript(i: Int) -> Room {
        get {
            return rooms[i]
        }
        set {
            rooms[i] = newValue
        }
    }
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
    var address: Address?
}


//Accessing properties through optional chaining
class Address2{
    var city = "Banglore"
}
class person2{
    var address : Address2?
}
let abhi = person2()
print(abhi.address ?? "A")


//Accessing Subscripts of Optional Type
var scores = ["A": [100,83,90], "B": [80,32,45], "C": [90]]
scores["A"]?[0] = 200
scores["B"]?[1] += 5
scores["C"]?[0] -= 10
print(scores["A"] ?? 0)
print(scores["B"] ?? 0)
print(scores["C"] ?? 0)


//Linking Multiple Levels of Chaining
class Address3{
    var city: String?
}
class Person3{
    var address :Address?
}
let person = Person3()
person.address = Address()
person.address?.street = "123"

let street = person.address?.street
print(street ?? "no Street")


//Chaining on Methods with Optional Return Values
class Address1{
    var buildingname:String?
    var buildingNumber:Int?
    var street:String?
    func buildingIdentifer() -> String? {
        if let buildingname{
            return buildingname
        }else if let buildingNumber,let street{
            return "\(buildingNumber) \(street)"
        }else{
            return nil
        }
        
    }
}

class Residence2 {
    var address : Address1?
}
class person4{
    var residence : Residence2?
}

let ajay = person4()
let result = ajay.residence?.address?.buildingIdentifer()?.hasPrefix("1")
print(result ?? "unknow")

ajay.residence = Residence2()
ajay.residence?.address = Address1()
ajay.residence?.address?.buildingNumber = 876
    
let result1 = ajay.residence?.address?.buildingIdentifer()?.hasPrefix("THE")
print(result1 ?? "uff")

if result1 == true {
    print("The building identifier begins with \"The\".")
}

ajay.residence?.address?.buildingNumber = 876
ajay.residence?.address?.street = "MG Road"
print(ajay.residence?.address?.buildingIdentifer() ?? "No Address")
