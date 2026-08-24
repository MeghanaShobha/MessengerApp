import UIKit


//for loop
let numss=1...10
for number in numss{
    print("each no in let numss is  \(number)")
}

let numsss=1..<10
for numbers in numsss{
    print("each no in let numss is  \(numbers)")
}

for _ in 1...5 {
    print("play")
}

let namess = ["Sterling", "Cyril", "Lana", "Ray", "Pam"]

for _ in namess {
    print("[CENSORED] is a secret agent!")
}

let namesss = ["Sterling", "Cyril", "Lana", "Ray", "Pam"]
for name in namesss {
    print("\(name) is a secret agent")
}

//while loop
var start = 1
while start <= 20{
    print(start)
    start += 1
}
print("done")


//repeat loops
var number = 1
repeat {
    print(number)
    number += 1
} while number <= 20

print("Ready or not, here I come!")


//exiting loop
let scores = [1,2,3,4,5,6,7,8]
var count = 0
for score in scores{
    if score == 5{
        break
    }
    count += 1
}
print("You had \(count) scores before you got 5.")


//existing multiple loops
for i in 1...5{
    for j in 1...10{
        let product = i*j
        print("\(i) *\(j) = \(product)")
    }
}

outerLoop: for i in 1...5{
    for j in 1...10{
        let p = i*j
        print("\(i) * \(j) is \(p)")
        
        if p == 45{
            print("over")
            break outerLoop
        }
    }
}


//swift have lablled statements because if we want to end the nested loops it will be helpfull
let o = ["up","down","left","right"]
let s = ["up","up","right"]
for op1 in o{
    for op2 in o{
        for op3 in o{
            let attempt = [op1,op2,op3]
            if attempt == s{
                print("the combination of \(attempt)")
                
            }
        }
    }
}

outerLoop: for op1 in o{
    for op2 in o{
        for op3 in o{
            let attempt = [op1,op2,op3]
            if attempt == s{
                print("the combination of \(attempt)")
                break
                
            }
        }
    }
}


var distanceFlown = 0
while true {
    distanceFlown += 100
    if distanceFlown == 500 {
        continue
    }
    print(distanceFlown)
    if distanceFlown == 1000 {
        break
    }
}

for i in 1...100 {
    if 100.isMultiple(of: i) {
        print("100 divides evenly into \(i)")
    } else {
        continue
    }
}


//infinate loop
var counter = 0
while true {
    print("hi")
    counter+=1
    if counter == 20{
        break // with out break statement thatis infinate loop
    }
}


//var counters = 1
//repeat {
//    print("Counting: \(counter)")
//    counters += 2
//} while counters != 10



var m = 3
if m < 10 {
    defer {
        print(m)
    }
    defer {
        print("The score is:")
    }
    m += 5
}

// for case...where
let points = [(1,1),(2,3),(4,4),(5,8),(7,7)]
for case let (x,y) in points where x==y{
    print(x,y)
}



//throw error
enum loginerror : Error{
    case invalidPassword
}
func login(password: String) throws{
    if password != "Swift123"{
        throw loginerror.invalidPassword
    }
    print("login successfull")
}

do{
    try login(password: "Swift123")
}catch{
    print("login fails")
}

//enum
enum Beverage: CaseIterable {
    case coffee, tea, juice
}
let numberOfChoices = Beverage.allCases.count
print("\(numberOfChoices) beverages available")
for beverage in Beverage.allCases{
    print(beverage)
}


//Associated Values
/*Associated values allow an enum case to store additional data along with the case.
 Think of it like this:
 A normal enum only tells you which case it is.
 An enum with associated values tells you which case it is and stores extra information.*/
enum Result {
    case success(String)
    case failure(String)
}
let r1 = Result.success("Data loaded successfully")
let r2 = Result.failure("Network Error")
print(r1)
print(r2)

//different datatype
enum payment{
    case cash
    case card(cardnumber : String)
    case upi(upinumber : String)
}
let p1 = payment.cash
let p2 = payment.card(cardnumber : "nsdihiuehd2873678")
let p3 = payment.upi(upinumber : "kjhdiuwh8173")
print("these are three types of payment")
print(p1)
print(p2)
print(p3)


//Real-Life Example
enum result1{
    case success(name : String)
    case fail(error : String)
}
let login = result1.success(name:"Ajay")
let logins = result1.fail(error:"sdhi")
switch login{
case .success(let name):
    print("login success with \(name)")
case .fail(let error):
    print("login is not success because of error")
}


switch logins{
case .success(let name):
    print("login success with \(name)")
case .fail(let error):
    print("login is not success because of error")
}


//Raw Values
//Every case has a fixed value.
enum days:String{
    case monday = "mon"
    case tuesday = "tue"
    case wednesday = "wed"
}
print(days.monday.rawValue)


//Associated Values
//Values are provided when you create the enum.
enum employee{
    case manager(name:String, id:Int)
}
let emp = employee.manager(name: "Ajay", id: 100)


/*| Raw Values               | Associated Values                  |
 | ------------------------ | ---------------------------------- |
 | Fixed at enum definition | Passed when creating the enum case |
 | Same value every time    | Can be different every time        |
 | Access with `.rawValue`  | Access with `switch` or `if case`  |
 | Example: `"Mon"`         | Example: `"Meghana", 22`           |
*/

//Implicitly Assigned Raw Values
enum planet:Int{
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}
let p = planet.earth.rawValue
print(p)
let possiblePlanet = planet(rawValue: 7)
print(possiblePlanet!)

let positionToFind = 9
if let somePlanet = planet(rawValue: positionToFind){
    switch somePlanet{
    case .earth:
        print("Mostly harmless")
    default:
        print("Not a safe place for humans")
    }
}else{
    print("there isnt a planet at position \(positionToFind)")
}

// Prints "There isn't a planet at position 11".


//Recursive Enumerations - it is like recursion
/*A recursive enumeration is an enum where one of its cases contains another instance of the same enum.
 An enum that refers to itself is called a recursive enum.
 */

//Without indirect
//enum ArithmeticExpression {
//    case number(Int)
//    case addition(ArithmeticExpression, ArithmeticExpression)
//}


//Using indirect
indirect enum ArithmeticExpression{
    case number(Int)
    case addition(ArithmeticExpression, ArithmeticExpression)
}
func evaluate(_ expression : ArithmeticExpression) -> Int{
    switch expression{
    case .number(let value):
        return value
    case .addition(let lhs, let rhs):
        return evaluate(lhs)+evaluate(rhs)
    }
}
let five = ArithmeticExpression.number(5)
let three = ArithmeticExpression.number(3)
let sum = ArithmeticExpression.addition(five, three)
print(evaluate(sum)) // value
//print(sum) //address


indirect enum ArithmeticExpressions {
case number(Int)
case addition(ArithmeticExpressions, ArithmeticExpressions)
case multiplication(ArithmeticExpressions, ArithmeticExpressions)
}
func evaluate(_ expression: ArithmeticExpressions) -> Int {
    switch expression {
    case .number(let value):
        return value
    case .addition(let lhs, let rhs):
        return evaluate(lhs) + evaluate(rhs)
    case .multiplication(let lhs, let rhs):
        return evaluate(lhs) * evaluate(rhs)
    }
}
let fives = ArithmeticExpressions.number(5)
let twentythree = ArithmeticExpressions.number(23)
let four = ArithmeticExpressions.number(4)

let multiply = ArithmeticExpressions.multiplication(twentythree , four)

let expression = ArithmeticExpressions.addition(fives, multiply)
print(evaluate(expression))
print(evaluate(multiply))


//Real-Life Example: File System
//A folder can contain files and other folders.
indirect enum fileSystem {
    case file(String)
    case folder(String, [fileSystem])
}
let documents = fileSystem.folder("Documents", [.file("Resume.pdf"), .file("ToDoList.txt")])
print(documents) // documents are ok but inside list i am getting address
