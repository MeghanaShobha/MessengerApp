import UIKit

func hi(){
    print("hiii")
}
hi()

func fav(name:String){
    print("My fav is \(name)")
}
fav(name: "swift")



func Movie(name:String,year:Int){
    print("\(name) was released in \(year)")
}
Movie(name: "googly", year: 2002)
Movie(name: "love mock tail",year: 2020)



func countLetter(string:String){
    print("The string is \(string) has \(string.count) letters")
}
countLetter(string: "Hello i am meghana")


func letterCount(myString str:String){
    print("the String \(str) has \(str.count) letters")
}
letterCount(myString: "hello")


func letter(_ str:String){
    print("The String \(str) has \(str.count) letters")
}
letter("hello world")


func letterCount(in str:String){
    print("The String \(str) has \(str.count) letters")
}
letterCount(in: "world")


func album(name:String)-> Bool{
    if name == "hello"{return true}
    if name == "hi"{return true}
    if name == "k"{return true}
    if name == "Meghana"{return true}
    if name == "red"{return true}
    return false
}
let a = album(name: "hello")
print(a)

if album(name:"Red"){
    print("That's one of hers!")
}else{
    print("Who made that?!")
}

if album(name:"Blue"){
    print("That's one of hers!")
}else{
    print("Who made that?!")
}


func hii()->Int{
    return 23
}
hii()

func hiiii()->Int{
    34
}
hiiii()

func hello()->String{
    return "hello singer"
}
hello()


func hello1()->String{
    "hello singer1"
}
hello1()

func getHare(weather:String)->String?{
    if weather == "Sunny"{
        return nil
    }else{
        return "hate"
    }
}
getHare(weather: "hiiii")
getHare(weather: "Sunny")


var s:String?
s = getHare(weather: "rainy")

func takeHate(status:String){
    if status == "Hate"{
        print("Hating")
    }
}



func gethaterStatus(weather:String)->String?{
    if weather == "Sunny"{
        return nil
    }else{
        return "hate"
    }
}
func takeHater(status:String){
    if status == "hate"{
        print("hating")
    }
}
if let haterStatus = gethaterStatus(weather: "rainy"){
    takeHate(status: haterStatus)
}


func yearAlbum(name:String)->Int{
    if name == "Taylor Swift" {return 2006}
    if name == "FearLess" {return 2008}
    return 0
}
yearAlbum(name: "lantern")



var items = ["James", "John", "Sally"]
func position(of String: String, in array: [String])->Int{
    for i in 0..<array.count{
        if array[i] == String{
            return i
        }
    }
    return 0
}

let jamesposition = position(of: "james", in: items)
let johnPostion = position(of: "john", in: items)

let sally = items.firstIndex(of: "sally")



func yearAlbum1(name:String)->Int? {
    if name == "Taylor Swift" {return 2006}
    if name == "FearLess" {return 2008}
    return nil
}
var year = yearAlbum(name: "FearLess")
if year == nil {
    print("There was an error")
}else{
    print("it was released in \(year)")
}


func albumReleased(year:Int)->String?{
    switch year{
    case 2006:return "Taylor Swift"
    case 2008:return "FearLess"
    case 2010:return "Speak Now"
    case 2012:return "Red"
    default:return nil
    }
}
let album = albumReleased(year: 2006)
print("the album is \(album ?? "a")")


let str = "Hello World"
print(str.uppercased())
    

let album1 = albumReleased(year: 2006)?.uppercased()
print("the album is \(album1 ?? "A")")


let album2 = albumReleased(year: 2006) ?? "Unknown"
print("The album is \(album ?? "a")")


func gatHater1(weather:String)-> String?{
    if weather == "Sunny"{
        return nil
    }else{
        return "Hate"
    }
}


enum weatherType{
    case sun, cloud, rain, wind, snow
}
func getHaterStatus(weather: weatherType)->String?{
    if weather == weatherType.sun{
        return nil
    }else{
        return "hate"
    }
}
getHaterStatus(weather: weatherType.cloud)


enum WeatherType{
    case sun
    case cloud
    case rain
    case wind
    case snow
}
//func weather(weather1:WeatherType)->String?{
//    if weather1 == .sun{
//        return nil
//    }else{
//        return "Hate"
//    }
//}
func weather(weather1:weatherType)->String?{
    switch weather1{
    case .sun:
        return nil
    case .cloud,.wind:
        return "dislike"
    case .rain:
        return "hate"
    case .snow:
        return "love"
    }
}
print(weather(weather1: .cloud) ?? "No option")



enum WeatherType1{
    case sun
    case cloud
    case rain
    case wind(speed:Int)
    case snow
}
func getHaterStatus(weather: WeatherType1)->String?{
    switch weather{
    case .sun:
        return nil
    case .wind(let speed) where speed < 10:
        return "make"
    case .cloud, .wind:
        return "dislike"
    case .rain, .snow:
        return "hate"
    }
}

/*print(getHaterStatus(weather: .wind(speed: 5)) as Any)  */ //optional("meh")
if let status = getHaterStatus(weather: .wind(speed: 5)) {
    print(status)
}
print(getHaterStatus(weather: .wind(speed: 4)) ?? "a") // Nil Coalescing Operator
print(getHaterStatus(weather: .wind(speed: 4))!) //Force Unwrap


func knock(_ caller:String?){
    print("who's there?")
    switch caller{
    case .none:
        print("*Silence*")
    case .some(let person):
        print(person)
    }
}
knock(nil)
knock("orange")

struct person{
    var clothes:String
    var shoes:String
}
let taylor = person(clothes: "T-shirts", shoes: "sneakers")
let  other = person(clothes: "short skirts", shoes: "high heels")
print(taylor.clothes)
print(other.shoes)


struct Person{
    var clothes:String
    var shoes:String
}
let taylor1 = person(clothes: "T-shirts", shoes: "sneakers")
let  other1 = person(clothes: "short skirts", shoes: "high heels")

var taylorCopy = taylor
taylorCopy.shoes = "flip flops"

print(taylor)
print(taylorCopy)

struct Person4{
    var clothes:String
    var shoes:String
    func describe() {
        print("I like wearing \(clothes) with \(shoes)")
    }
}
let taylor2 = Person4(clothes: "T-Shirt", shoes: "sneakers")
taylor2.describe()


class Person5{
    var clothes: String
    var shoes: String
    init(clothes:String,shoes:String){
        self.clothes = clothes
        self.shoes = shoes
    }
}


class Singer{
    var name:String
    var age:Int
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    func sing(){
        print("lalala")
    }
}
var v = Singer(name: "rani", age: 10)
print(v.name)
v.age
v.sing()

class CounterySinger : Singer{
    override func sing(){
        print("Trucks, guitars, and liquor")
    }
}
var taylor3 = CounterySinger(name: "ajith", age: 13)
taylor3.sing()

class HMS:Singer{
    var nl:Int
    init(name:String,age:Int,nl:Int){
        self.nl = nl
        super.init(name:name, age:age)
    }
    override func sing(){
        print("singing......")
    }
}

print("this is value type")
//values v/s Reference
//value type

struct Person6{
    var name:String
}
var p1 = Person6(name: "Meghana")
var p2 = p1  //copy created

p2.name = "Ajay"
print(p1.name)
print(p2.name)

print("this is reference type")
//reference type
class person7{
    var name:String
    init(name:String){
        self.name = name
    }
}
let p3 = person7(name: "A")
let p4 = p3  //same object
p4.name = "Ajay"
print(p3.name)
print(p4.name)



struct person8{
    var marks :Int
}
func update(student:person8){
    var s = student
    s.marks = 3
}
var s1 = person8(marks: 65)
update(student: s1)
print(s1.marks)


class person9{
    var marks :Int
    init(marks:Int){
        self.marks = marks
    }
}
func update1(student:person9){
    var ss = student
    ss.marks = 34
}
var s2 = person9(marks: 20)
update1(student: s2)
print(s2.marks)


struct equal:Equatable{
    var name:String
}
var name = equal(name: "A")
var name1 = equal(name: "A")
print(name == name1)


class Book{
    var title :String
    init(title:String){
        self.title = title
    }
}
let b1 = Book(title: "A")
let b2 = b1
let b3 = Book(title: "A")

print(b1 === b2)
print(b1 === b3)


//let aaaa = 26°c //to get the ° we have to use shift + option + 8


//storing ordered data in the arrays
var characters = ["Lana", "Pam", "Ray", "Sterling"]
print(characters.count)

characters.remove(at: 2)
print(characters.count)

characters.removeAll()
print(characters.count)

let presidents = ["Bush", "Obama", "Trump", "Biden"]
let reversedPresidents = presidents.reversed()
print(reversedPresidents)
