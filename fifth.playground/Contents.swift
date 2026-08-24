import UIKit

func printmessage() {
    let message = """
    hi i am meghana
    how are you
    i am very happy here
    """
    print(message)
}
printmessage()


//accepting parameters
func square(number:Int){
    print(number*number)
}
square(number: 5)

//return
func greet(name:String) -> String{
    let resp = if name == "meghana" {
        "oh wow"
    }else{
        "sorry"
    }
    return resp
}
print(greet(name: "meghana"))


//return with ternary conditional operator
func greets(name:String) ->String{
    let resps = name == "Meghana" ? "i am meghana" : "sorry i am not meghana"
    return resps
}
print(greets(name : "Meghana"))



//how can we written 2 or more values in this function
func hi() -> [String : String]{
    ["meghana":"hi","yashu":"hello","hruthik":"see you"]
}
let result = hi()
print(result["meghana"] ?? "unknown")



//in tuple we cant able to provide the string or mutable data for keys as same as python
func hello() -> (name:String,age:Int){
    let respss = (name:"meghana",age:24)
    return respss
}
let resultt = hello()
print(resultt.name)
print(resultt.age)


//omitting parameters or callsite
func greett(_ name:String) -> String{
    "hello \(name)"
}
print(greett("srinivas"))


//default parameter
func greett(name:String,with greeting:String = "hello") -> String{
    "\(greeting) \(name)"
}
print(greett(name: "Srinivas", with :"hi"))

//variadic function
func cube(numbers : Int...){
    for number in numbers{
        print("\(number) cube is \(number*number*number)")
    }
}
print(cube(numbers: 1,2,3,4,5))

//throws function
enum PasswordError: Error {
    case obvious
}
func so(_ password:String) throws -> Bool{
    if password == "Password"{
        throw PasswordError.obvious
    }
    return true
}

do{
    let result = try so("Meghana@122")

    if result{
        print("it is correct")
    }
}catch{
    print("it is not correct")
}

//running throwing functions
//do is start a section of code that calls if any errors are thrown. execute immediatelly jumps to the catch block

//inout parameter
func double(_ num: inout Int){
    num *= 2
}
var x = 10
double(&x)
double(&x)
print(x)


//Updating a value
func increment(_ num: inout Int){
    num+=1
}
var y = 10
increment(&y)
print(y)
increment(&y)
print(y)

//Swapping two values
func swap(_ a: inout Int, _ b: inout Int){
    (a,b) = (b,a)
}
var a = 10
var b = 20
swap(&a ,&b)
print(a,b)


//Resetting a value
func reset(_ value: inout Int){
    value = 89
}
var value = 90
reset(&value)
print(value)

//Modifying a collection
func additem(_ item:String,to list: inout [String]){
    list.append(item)
}
var fruits = ["apple","mango"]
additem("orange", to : &fruits)
print(fruits)



