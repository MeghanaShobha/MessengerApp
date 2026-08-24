import UIKit

/*
 Higher-Order Functions in Swift
 
 A higher-order function is a function that does at least one of these:
 Takes another function/closure as a parameter
 Returns a function/closure
 Or does both.
 */

/*In Swift, the most common higher-order functions are:
 map()
 filter()
 reduce()
 sorted()
 forEach()
 compactMap()
 flatMap()
 contains()
 removeAll()
 split()
 */

//1. map()
//map() takes each item in an array, applies some operation to it, and creates a new array containing the changed values.
let numbers = [1,2,3,4,5]
let doubled = numbers.map { numbers in numbers * 2 }
print(doubled)


let numbers1 = [1,2,3,4,5]
let doubled1 = numbers1.map { $0 * 2 }
print(doubled1)

let num = [2, 5, 3, 9, 15, 12, 8, 17, 20, 11]
var double = [Int]()
for number in num {
    double.append(number * 2)
}
print(double)
double = num.map({ (number) -> Int in return number * 2})
let double2 = numbers.map { $0 * 2 }

let degrees = [20, 45, 160, 360, 84, 215, 178, 185]
let rads = degrees.map { Double($0) * Double.pi / 180.0 }

var rad = [Double]()
for deg in degrees {
    rad.append(Double(deg) * Double.pi / 180.0)
}

let strings = ["1", "2", "3", "4", "5"]
let integers = strings.map { Int($0)!}
print(integers)


/*
 2. filter()
 filter() keeps only the elements that satisfy a condition.
 */
let number = [1,2,3,4,5,6]
let even = number.filter{number in number % 2 == 0}
print(even)

let number1 = [1,2,3,4,5,6]
let even1 = number1.filter{$0 % 2 == 0}
print(even1)


/*3. reduce()
 reduce() combines all elements into a single value.*/
let number2 = [1,2,3,4,5,6]
let total = number2.reduce(0){ result, number2 in result + number2}
print(total)

/*4. sorted()
 sorted() returns the elements in a specified order.*/
let numbers3 = [5, 2, 8, 1, 3]
let sortedNumbers = numbers3.sorted { a, b in
    a < b
}
print(sortedNumbers)


/*5. forEach()
 forEach() performs an operation for every element.*/
let names = ["meghana","yashu","hruthik","Ajay"]
names.forEach { name in print(name)}
names.forEach{print($0)}

let num2 = [2, 5, 3, 9, 15, 12, 8, 17, 20, 11]
for number in num2 {
    number.isMultiple(of: 2) ? print("\(number) is even") : print("\(number) is odd")
}

var counter = 0
let num8 = [1, 2, 3, 4, 5]
num8.forEach { if $0 % 2 == 0 { counter += 1 } }
print("counter =",counter)

/*6. compactMap()
 compactMap() transforms values and removes nil results.*/
let values = ["10","3","hello","7"]
let numbers4 = values.compactMap{Int($0)}
print(numbers4)

let optionals: [Int?] = [1, 2, nil, 4, nil]
let I = optionals.compactMap { $0 }
print("I = ",I)

//7.Combining Higher-Order Functions
let numbers5 = [5, 2, 8, 1, 3,23,56,78]
let result = numbers5
    .filter{$0 % 2 == 0}
    .map{$0 * 10}
print(result)

//8. flatMap()
//flatMap() is useful when you have nested collections and want to flatten them into one collection.
let numbers6 = [[11,12], [91,14], [15,61]]
let res = numbers6.flatMap{$0}
print(res) // [11, 12, 91, 14, 15, 61]

/*9. contains()
contains() checks whether a collection contains a particular value.*/
let numbers7 = [1,2,3,4,5]
print(numbers7.contains(10))
print(numbers7.contains(1)) 


let numbers8 = [10, 15, 20, 25]
let result8 = numbers8.contains { $0 > 20 }
print(result8)

    
/*10. removeAll()
 removeAll() removes all elements from a collection.*/
var numbers9 = [1,2,3,4,5,65,7,89,76]
numbers9.removeAll()
print(numbers9)


/*11. split()
 split() divides a collection into smaller pieces based on a separator or condition.*/
let sentance = "hi my name is meghana wt is your name"
let words = sentance.split(separator: " ")
print(words)

let message = "Hello, World!"
let res2 = message.split { (char) -> Bool in
    return char == ","
}
print(res2)

let m = "hello i am megha"
let res3 = m.split{$0 == " "}
print(res3)

let allstring = result.map{String($0)}
print(allstring)

let paragraph = "This paragraph will be separated in parts. Based on the periods and the exclamation mark! There will be three strings!"
let breakingpoint = paragraph.split{$0 == "." || $0 == "!"}
print(breakingpoint)




