import UIKit
import Foundation

enum StackError: Error {
    case Empty(message:String)
}
public struct Stack{
    var array:[Int] = []
    init(capacity:Int){
        array.reserveCapacity(capacity)
    }
    public mutating func push(element:Int){
        array.append(element)
    }
    public mutating func pop() -> Int {
        return array.popLast()!
    }
    public func peek()throws -> Int {
        guard !isEmpty(),let lastElement = array.last else {
            throw StackError.Empty(message: "Array is empty")
        }
        return lastElement
    }
    func isEmpty() -> Bool {
        return array.isEmpty
    }
}
extension Stack: CustomStringConvertible {
    public var description: String {
        let elements = array.map{"\($0)"}.joined(separator: "\n")
        return elements
    }
}

var stack = Stack(capacity: 10)
stack.push(element: 1)
stack.push(element: 2)
stack.push(element: 3)
stack.pop()
print(stack)
stack.push(element: 4)
print(stack)



enum StackError1: Error {
    case Empty(message:String)
}
public struct Stack1<T>{
    var array:[T] = []
    init(capacity:Int){
        array.reserveCapacity(capacity)
    }
    public mutating func push(element:T){
        array.append(element)
    }
    public mutating func pop() -> T? {
        return array.popLast()
    }
    public func peek()throws -> T {
        guard !isEmpty(),let lastElement = array.last else {
            throw StackError.Empty(message: "Array is empty")
        }
        return lastElement
    }
    func isEmpty() -> Bool {
        return array.isEmpty
    }
}

extension Stack1:CustomStringConvertible{
    public var description: String {
        let elements = array.map{"\($0)"}.joined(separator: "\n")
        return elements
    }
}

var stringStack = Stack1<String>(capacity: 10)
stringStack.push(element:"meghana")
print(stringStack)

struct IntStack {
    var items: [Int] = []
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
}

struct StringStack {
    var items: [String] = []
    mutating func push(_ item: String) {
        items.append(item)
    }
    mutating func pop() -> String {
        return items.removeLast()
    }
}

struct  Stack2<Element> {
    var items: [Element] = []
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
}


struct Person {
    let name: String
    let age: Int
}
let people = [
    Person(name: "Meghana", age: 25),
    Person(name: "Rahul", age: 30),
    Person(name: "Anu", age: 20)
]
var peopleSortedByNameLength: [Person] {
    people.sorted {
        $0.name.count > $1.name.count
    }
}

@MainActor func longestName() -> String{
    return peopleSortedByNameLength
        .first!
        .name
}
@MainActor func shortName() -> String{
    return peopleSortedByNameLength
        .last!
        .name
}


func swapValue<T>(_ a: inout T, _ b: inout T) {
    let temp = a
    a = b
    b = temp
}
var x = 5
var y = 10
swapValue(&x, &y)

// Finding the Index of an Equatable Element
func findIndex<T:Equatable>(of valueToFind:T,in array:[T]) -> Int?{
    for(index,value)in array.enumerated(){
        if value == valueToFind{
            return index
        }
    }
    return nil
}


func swapTwoStrings(_ a: inout String, _ b: inout String) {
    let temporaryA = a
    a = b
    b = temporaryA
}
func swapTwoDoubles(_ a: inout Double, _ b: inout Double) {
    let temporaryA = a
    a = b
    b = temporaryA
}

func swapTwoVAlues<T>(_ a: inout T, _ b: inout T) {
    let temporaryA = a
    a = b
    b = temporaryA
}
var a = 37
var b = 72
swapTwoVAlues(&a, &b)


struct IntStack1{
    var items :[Int] = []
    mutating func push(_ item: Int){
        items.append(item)
    }
    mutating func pop() -> Int{
        return items.removeLast()
    }
}


struct Stack3<Element>{
    var items: [Element] = []
    mutating func push(_ item: Element){
        items.append(item)
    }
    mutating func pop() -> Element{
        return items.removeLast()
    }
    
}

var stackOfStrings =  Stack3<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")
stackOfStrings.push("cuatro")

extension Stack3 {
    var topItem:Element?{
        return items.isEmpty ? nil :items[items.count-1]
    }
}

if let topItem = stackOfStrings.topItem{
    print("The top item on the stack is \(topItem).")
}

func findIndex(ofString valueToFind: String, in array:[String]) -> Int?{
    for (index, value) in array.enumerated(){
        if value == valueToFind{
            return index
        }
    }
    return nil
}


let strings = ["cat", "dog", "llama", "queen", "parakeet", "dog"]
if let foundIndex = findIndex(ofString: "llama", in: strings){
    print("The index of llama is \(foundIndex)")
}

func findIndex<T>(of valueToFind: T,in array :[T])->Int?{
    for (index,value) in array.enumerated() {
        if value == valueToFind{
            return index
        }
    }
    return nil
}
