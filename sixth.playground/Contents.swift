import UIKit

//closures
//Closures are self-contained blocks of functionality that can be passed around and used in your code. Closures in Swift are similar to closures, anonymous functions, lambdas, and blocks in other programming languages.
let drive = {
    print("i am driving")
}
drive()//it works like function

//with parameters
let str = {(place:String) in
    print("i am driving to \(place)")
}
str("doddaballapur")

//function type
func pay(user:String, id:Int){
    print("it is pay")
}

//this is closures type
let pays = {(user:String, id:Int) in
    print("it is closures")
}


//returning values
let hello = {(_user:String,_id:Int)->String in
    return "returning values with swift"
}
print(hello("hello",23))


let hello1 = {(user:String)-> Bool in
    print("....hi")
    return true
}
print(hello1("hi"))

func driving() {
    print("I'm driving to work")
}
func travel(action: ()->Void){
    action()
    print("i am getting late")
    action()
    print("i am on my way")
    action()
}
travel(action: driving)



//trailing closure syntax
func tryy(action : () -> Void){
    print("hi")
    action()
    print("hello")
}
tryy(){
    print("how are u")
}
//tryy{
//    print("i am super good")
//}


func hiii(time:Int,sleep: () -> Void){
    print("hello sis")
    sleep()
}

hiii(time:3){
    print("sis is my heart")
}

hiii(time:4,sleep:{
    print("sing a song for sis")
})


//max and min number
func minMax(array:[Int]) -> (min:Int,max:Int){
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array{
        if value<currentMin{
            currentMin=value
        }else if value>currentMax{
            currentMax=value
        }
    }
    return (currentMax,currentMin)
}

let values = minMax(array:[1,12,3,4,56,67,345,56,7])
print("max = \(values.max) ,min = \(values.min)")


//finding a mean
func arithmeticMean(_ numbers:Int...) -> Double{
    var total: Double = 0
    for number in numbers{
        total += Double(number)
    }
    return total/Double(numbers.count)
}

let val = arithmeticMean(1,2,3,4,5,6)
print(val)

//escaping closures
//@escaping
var completionHandlers:[()->Void]=[]
@MainActor func escapingClosure(completionHandler:@escaping()->Void){
    completionHandlers.append(completionHandler)
}

//nonescaping closures
func nonescapingClosure(closure:()->Void){
    closure()
}
class main{
    var x = 10
    @MainActor func doo(){
        escapingClosure{self.x = 100}
        nonescapingClosure{x=200}
    }
}
let instance = main()
instance.doo()
print(instance.x)

completionHandlers.first?()
print(instance.x)

//function as a parameter
func square(number: Int) -> Int {
    return number * number
}
func calculate(value: Int, operation: (Int) -> Int) {
    let result = operation(value)
    print(result)
}
calculate(value: 5, operation: square)



func add(a: Int, b: Int) -> Int {
    return a + b
}
func performMath(_ operation: (Int, Int) -> Int) {
    let result = operation(10, 20)
    print(result)
}
performMath(add)
