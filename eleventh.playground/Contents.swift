import UIKit

//protocols
protocol MyProtocol {
    var text: String { get }
}
struct user: MyProtocol {
    var text: String
}
func display (user: MyProtocol) {
    print("my name is: \(user.text)")
}
let someUser = user(text: "shobha")
display(user: someUser)


struct Book{
    var name:String
}
func buy(_ book: Book){
    print("i a buying \(book.name)")
}


protocol purchasable{
    var name:String{get}
}
struct Book1:purchasable{
    var name: String
    var price:Int
}
struct movie:purchasable{
    var name:String
    var showtime:Double
}
struct car:purchasable{
    var name:String
    var rent:Bool
}
func buy(item:purchasable){
    print("i am buying \(item.name)")
}
let book1 = Book1(name: "swift", price: 100)
let movie1 = movie(name: "sholay", showtime: 10.9)
let car1 = car(name: "audi", rent: true)
buy(item: book1)
buy(item: movie1)
buy(item: car1)


//Protocol inheritance
protocol A{
    func calculateWages() -> Int
}
protocol B{
    func study()
}
protocol C{
    func takeVacation(days: Int)
}
protocol Employee:A,B,C {}


//Extensions
extension Int{
    func squared() -> Int{
        return self * self
    }
}
let result = 5
print(result.squared())


extension Int{
    var isEven: Bool{
        return self % 2 == 0
    }
}
let d = 10
print(d.isEven)

//protocol extension
let pythons = ["Eric", "Graham", "John", "Michael", "Terry", "Terry"]
let beatles = Set(["John", "Paul", "George", "Ringo"])
extension Collection {
    func summarize(){
        print("there are \(self.count) items in this collection")
        
        for name in self{
            print(name)
        }
    }
}
pythons.summarize()
beatles.summarize()


//allSatisfy() method that returns true if all the items in the array pass a test.
let numbers = [12,24,22,26,37,99,56,332,22,34,45]
let alleven = numbers.allSatisfy{ $0.isMultiple(of: 2)}
let even = alleven
print(even)

let numbers1 = Set([12,24,22,26,37,99,56,332,22,34,45])
let alleven1 = numbers.allSatisfy{ $0.isMultiple(of: 2)}
let even1 = alleven1
print(even1)

let numbers3 = ["four":4,"six":6,"eight":8,"ten":10]
let alleven2 = numbers3.allSatisfy{ $0.value.isMultiple(of: 2)}
let even2 = alleven2
print(even2)


//Protocol-oriented programming
//Identifiable that requires any conforming type to have an id property and an identify() method
protocol Identifiable{
    var id: String { get }
    func identify()
}
extension Identifiable{
    func identify(){
        print("My id is \(self.id)")
    }
}
struct User : Identifiable{
    let id: String
}
let two = User(id: "2")
two.identify()
