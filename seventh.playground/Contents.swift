import UIKit

//Using closures as parameters when they accept parameters
func login(then action:(String) -> Void){
    print("Authenticating")
    let user = "Meghana"
    action(user)
}
login{user in
    print("welcome to my page \(user)")
}



//travel
func getDirections(to destination:String,then travel:([String])->Void){
    let direction = [
        "Take the A1",
        "Turn right at the traffic light",
        "Continue for 5 miles\(destination)"
    ]
    travel(direction)
}
    
getDirections(to: "banglore"){(direction :[String]) in
    print("the car is waiting")
    for d in direction{
        print(d)
    }
    
}


//Using closures as parameters when they return values
func travell(action:(String)->String){
    print("i am getting ready to go")
    let description = action("Banglore")
    print(description)
    print("i arrived")
}
travell{(place : String)->String in
    return "i am going to \(place) in the car"
}


func reduce(_ values:[Int],using clouser :(Int,Int)->Int)->Int{
    var current = values[0]
    for i in values[1...]{
        current = clouser(current,i)
    }
    return current
}
let a = reduce([1,2,3,4,5,6]) { current, value in
    current + value
}
print(a)

let sum = reduce([1,2,3,4,5,6], using: +)
print(sum)

//Shorthand parameter names
func travel(action: (String) -> String) {
    print("getting ready to go")
    let description = action("Banglore")
    print(description)
    print("arrived")
}


travel{(place:String)-> String in
    return "I am going to \(place) in my car"
}

travel{ place -> String in
return "I am going to \(place) in my car"}

travel{place in return "I am going to \(place) in my car"}

travel {place in 
    "I am going to \(place) in my car"
}

//closures with multiple parameter
func travel(action: (String,Int)->String){
    print("i am getting ready")
    let description = action("londan",90)
    print(description)
    print("i arrived")
}
travel{
    "i am going to \($0) in \($1)" //$0 and $1 represent the index position of the parameters
}

//returnin closures from functions
func travel()->((String)->Void){
    return {
        print("i am going to \($0)")
    }
}
let result = travel()
result("banglore")
let result2: Void = travel()("Banglore")


//to makeRandomGenerator()
print(Int.random(in: 1...10))


func getrandom()->Int{
    Int.random(in: 1..<100)
}
print(getrandom())


func getrandomint() -> () -> Int{
    let number = {Int.random(in:1...100)}
    return number
}
let hi = getrandomint()
print(hi)
let hello=hi()
print(hello)

//Capturing values
func travel1()->(String)->Void{
    var c = 1
    return {
        print("\(c) is the value, i am going to\($0)")
        c+=1
    }
}
result("Banglore")

//random number Generator
func randomnumberGenerator() -> () -> Int{
    return {
        var previousnumber = 0
        var newNumber : Int
        repeat{
            newNumber = Int.random(in: 1...3)
        }while newNumber == previousnumber
        previousnumber = newNumber
        return newNumber
    }
}

let num = randomnumberGenerator()
let numm: () = print(num())

