import UIKit

//Subscripts in Swift
//A subscript is a special feature in Swift that lets you access values from your own types (classes, structures, and enumerations) using square bracket ([]) syntax, just like arrays and dictionaries.


//syntax
//subscript(parameters) -> ReturnType {
//    get {
//        // return value
//    }
//    set(newValue) {
//        // store new value
//    }
//}
//or
//subscript(parameters) -> ReturnType {
//    return value
//}

//read only subscript
struct Timetable{
    let m:Int
    subscript (index:Int) -> Int {
        return m * index
    }
}
let table = Timetable(m: 3)
print(table[2])
print(table[3])

//read and write subscript
struct Studentmarks{
    var marks = [80,93,99]
    subscript(index:Int) -> Int {
        get {
            return marks[index]
        }
        set(newValue) {
            marks[index] = newValue
        }
    }
}
var student = Studentmarks()
print(student[2])
student[2] = 100
print(student[2])

//using two parameters
struct Matrix{
    let rows = 3
    let columns = 3
    var grid = [
        1,2,3,
        4,5,6,
        7,8,9
    ]
    subscript(row : Int ,column : Int)->Int{
        grid[(row*columns)+column]
    }
}
let matrix = Matrix()
print(matrix[0,1])
print(matrix[1,2])
print(matrix[2,2])


//subscript usage
var numberoflegs = ["spider":8,"ant":6,"cat":4]
numberoflegs["bird"] = 2
print(numberoflegs)

//getter and setter in matrix
struct Matrix1{
    let column1 = 3
    var grid1 = [
        1,2,3,
        4,5,6,
        7,8,9
    ]
    subscript(row: Int,column: Int)->Int{
        get{
            grid1[(row*column1)+column]
        }
        set{
            grid1[(row*column1)+column] = newValue
        }
    }
}
var matrix1  = Matrix1()
print(matrix1[1,2])
matrix1[2,1] = 300
print(matrix1[2,1])
print(matrix1)


//Computed Property vs Subscript
//computed property
struct Square{
    var side:Int
    var area:Int{
        side*side
    }
}
let square = Square(side: 5)
print(square.area)


//Subscript
struct numbers{
    let values = [12,34,45,667,78,90]
    subscript(index:Int)->Int{
        values[index]
    }
}
let number = numbers()
print(number[3])



/*
 | Function                    | Subscript                        |
 | --------------------------- | -------------------------------- |
 | `student.getMark(1)`        | `student[1]`                     |
 | Has a name                  | No name                          |
 | Uses `()`                   | Uses `[]`                        |
 | Best for performing actions | Best for indexed or keyed access |
*/


//Subscript Options
struct Grid{
    var values=[
        [1,2],
        [3,4]
    ]
    subscript (row:Int,column:Int)->Int{
        get{
            values[row][column]
        }
        set{
            values[row][column] = newValue
        }
    }
}
var grid = Grid()
print(grid[1,1])
grid[1,1] = 100
print(grid[1,1])


//type Subscript
struct MathTable {
    static subscript(number: Int) -> Int {
        number * number
    }
}
print(MathTable[5])

//generic subscript
struct Box<T> {
var items: [T]
subscript(index: Int) -> T {
    items[index]
}
}
let numbers9 = Box(items: [10,20,30])
print(numbers9[1])
let names = Box(items: ["Tom","Jerry"])
print(names[0])



//Safe Subscript (Optional Return)
extension Array {
    subscript(safe index: Int) -> Element? {
        if indices.contains(index) {
            return self[index]
        }
        return nil
    }
}
let nums = [10,20,30]
print(nums[safe: 1]) //if we use ?? they it is not optional return
print(nums[safe: 10])

//Type Subscripts - A Type Subscript is a subscript that belongs to the type itself rather than an instance of the type. It is declared using the static keyword.

enum planet : Int{
    case mercury = 1,venus, earth, mars, jupiter, saturn, uranus, neptune
    static subscript(index:Int)->planet{
        planet(rawValue: index)!
    }
}
let mars = planet[4]
print(mars)


//Subscript Usage - A subscript is used when you want an object to be accessed like an array or dictionary using square brackets ([]) instead of calling a method.


//Without a subscript:
struct Student {
    var marks = [85, 90, 95]
    func getMark(at index: Int) -> Int {
        return marks[index]
    }
}
let student8 = Student()
print(student8.getMark(at: 1))

//with subscript
struct Student1 {
    static subscript(index: Int) -> String {
        ["Meghana", "Rahul", "Anu"][index]
    }
}
print(Student1[1])
