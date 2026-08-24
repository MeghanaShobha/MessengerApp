import UIKit

//Handling missing data   -   using ?
var age :Int? = nil
age = 24

//Unwrapping optionals - we can able to pass nil value
var name:String? = nil
if let unwrappedName = name {
    print("Hello, \(unwrappedName)")
} else {
    print("Hello, unknown user")
}



func getUsername() -> String? {
    "megha"
}
if let username = getUsername(){
    print("the user name is \(username)")
}else{
    print("no username")
}

//Unwrapping with guard - in the place of if let we are useing the guard let
func greet(_ name:String?){
    guard let unwrapped = name else{
        print("dont have name")
        return
    }
    print("Hello,\(unwrapped)!")
}
let a: () = greet(nil)


func getMeaningOfLife()->Int?{
    42
}
func printMeaningOfLife(){
    if let name = getMeaningOfLife(){
        print(name)
    }
}

func printMeaningOfLife1(){
    guard let name = getMeaningOfLife()else{
        return
    }
    print(name)
}
let aa = getMeaningOfLife()
print(aa ?? 0)

let bb: () = printMeaningOfLife()
let cc: () = printMeaningOfLife1()


//Nil coalescing - ??
let username:String? = nil
var displayName = username ?? "Guest"
print(displayName)


let username1:String? = "meghana"
let displayName1 = username1 ?? "Guest"
print(displayName1)

let displayname :String
if let username = username{
    displayName = username
}else{
    displayname = "guest"
}

let savedSource : Int? = nil
let source = savedSource ?? 0
print(source)



func loadSavedMessage() -> String?{
    return "hi"
}
let savedData = loadSavedMessage() ?? ""
print(savedData)




func first()->String?{
    return nil
}
func second()->String?{
    return "second"
}
let savedData1 = first() ?? second() ?? ""
print(savedData1)


let sources = ["hi":8237,"hello":128793,"hiii":92747032]
let seeyou = sources["Bye"] ?? 0
print(seeyou)
let seeyou1 = sources["Bye" , default: 0]
print(seeyou1)



//Optional chaining - a.b?.c here b is optional

let names = ["John","Megha","Yashu","Hruthik","Srinivas"]
let name1 = names.first?.uppercased()
let name200 = names
name200.first?.uppercased()

if let name3 = names.first{
    print("name3 =",name3)
    print("name3 upper case =",name3.uppercased())
}
print(name1 ?? "unknow")



let names1 = ["nil",nil,"Yashu","Hruthik","Srinivas"]
let name2 = names1.compactMap { $0 }.dropFirst().first?.uppercased()
print("name2 = ",name2 ?? "unknow")


let names2  = [nil,nil,"Yashu","Hruthik","Srinivas"]
let name3 = names2.compactMap{$0}.dropLast().dropFirst().first?.uppercased()
print(name3 ?? 0)

let names3  = [nil,nil,"Yashu","Hruthik","Srinivas"]
let name4 = names3[3]?.uppercased()
print(name3 ?? 0)

let numbers = [3, 1, 2]
let sortedNumbers = numbers.sorted { $0 < $1 }
print("sorted numbers = ",sortedNumbers)


//Optional try -try? when error is not important
enum passwordError: Error {
    case obvious
}
func checkpassword(_ password: String) throws -> Bool {
    if password  == "Password"{
        throw passwordError.obvious
    }
    return true
}
do{
    try checkpassword("Password")
    print("good password")
}catch{
    print("bad password")
}

if let result = try? checkpassword("Password"){
    print("Result was \(result)")
}else{
    print("ohhh!")
}

//let s = try! checkpassword("Password")
//print(s)

//Failable initializers - init?()
struct person{
    var id = String()
    init?(id:String){
        if id.count==9{
            self.id = id
        }else{
            return nil
        }
    }
}
let person1 = person(id: "123456789")
let person2 = person(id:"1928739863")


struct Employee{
    var username : String
    var password : String
    init?(username:String,password:String){
        guard password.count >= 8 else{return nil}
        guard password.lowercased() != "password"
        else{return nil}
        
        self.username = username
        self.password = password
    }
}
let lim = Employee(username: "lim", password: "12345678") //based on password length 8
print(lim ?? "unknow")
let craig = Employee(username: "craiggg", password: "18398")//based on password length 5
print(craig ?? "unknow")


//Typecasting
let aaa = 834
let bbb = String(aaa)
print(bbb)

let ccc:String = "1234"
let ddd:Int = Int(ccc)!
print(ddd)



class Animal{}
class Dog:Animal{
    func sound(){
        print("boow")
    }
}
let pet :Animal = Dog()
if let dog = pet as? Dog{
    dog.sound()
}

class Person{
    var name = "john"
}
class customer:Person{
    var id = 12324
}
class Employee1:Person{
    var salary = 30_000
}
let c = customer()
let e = Employee1()
let people = [c,e]

for person in people{
    if let customer = person as? customer{  //as? is the conditional type cast operator in Swift.
        print("ID: \(customer.id)")
    }else if let employee = person as? Employee1{
        print("earns: \(employee.salary)")
    }
}

