import UIKit
/*
 | Feature                            | Struct                     | Class          |
 | ---------------------------------- | -------------------------  | -------------- |
 | Type                               | Value Type                 | Reference Type |
 | Stored Properties                  | ✅ Yes                     | ✅ Yes          |
 | Computed Properties                | ✅ Yes                     | ✅ Yes          |
 | Methods                            | ✅ Yes                     | ✅ Yes          |
 | Initializers                       | ✅ Yes                     | ✅ Yes          |
 | Inheritance                        | ❌ No                      | ✅ Yes          |
 | Deinitializer (`deinit`)           | ❌ No                      | ✅ Yes          |
 | ARC (Automatic Reference Counting) | ❌ No                      | ✅ Yes          |
 | Identity Operator (`===`)          | ❌ No                      | ✅ Yes          |
 | Mutating Methods                   | Required for modification  | Not required   |
*/
//static
//A common use of static is to keep track of how many objects have been created.
//struct student{
//    static var a = 10
//    var name : String
//    init(name: String) {
//        self.name = name
//        student.a += 1
//    }
//}
//print(student.a)


//class and inheritanceCreating your own classes
class dog{
    var name : String
    var breed : String
    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
}
let myDog = dog(name: "Milo", breed: "Labrador")
print(myDog.name)
print(myDog.breed)


//Class inheritance
class animaldog{
    var name: String
    var breed: String
    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
}
class poddle: animaldog{
    init(name:String){
        super.init(name: "dog", breed: "poddle")
    }
}

//Overriding methods
class animal{
    func makeSound(){
        print("Some sound")
    }
}
class poddle1: animal{
    override func makeSound() {
            print("Woof!")
        }

}
let puppy = poddle1()
puppy.makeSound()

//Copying objects
class singer{
    var hii = 1000
}
var s = singer()
s.hii


//Force unwrapping
let str = "6hello3"
let word = Int(str)
print(word as Any)


let strr = "2"
let num = Int(strr)
let nums = Int(strr)!  //force unwrap
print(num ?? 0)
print(nums)


//When should you force unwrap optionals in Swift?

let url = URL(filePath: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/macros")!
print(url)
let urls = URL(string: "https://www.apple.com")!
print(urls)
let random = (1...10).randomElement() // if we didnt use the force unwrap then we have to use the default value
print(random ?? 0)
let randoms = (1...10).randomElement()! //if use the force unwrap we dont want to use default
print(randoms)




func isLuckyNumber(_ number: Int)->Bool {
    number.isMultiple(of: 3)  //because of this possible outcomes are 3,6,9
}
var items = [Int]()
for i in 1...10{
    if isLuckyNumber(i){
        items.append(i)
    }
}
let randomNumber = items.randomElement()!
if let randomnumber = items.randomElement(){
    print(randomNumber)
}


enum Direction : CaseIterable{
    case nort,south,east,west
}
let randomDirection = Direction.allCases.randomElement()!
print(randomDirection)



enum Direction1 : CaseIterable{
    case nort1,south1,east1,west1
    static func random()->Direction1{
        Direction1.allCases.randomElement()!
    }
}
let randomDirection1 = Direction1.random()
print(randomDirection1)


//Implicitly unwrapped optionals
var username: String!
username = "Meghana"
print(username ?? "unknow")

var usernames: String!
print(usernames ?? "unknow")

