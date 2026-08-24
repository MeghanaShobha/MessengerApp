import UIKit

//Extension
//An extension in Swift lets you add new functionality to an existing type


//1. Add a Method
extension Int {
    func Square() -> Int {
        return self * self
    }
}
print(5.Square())


//2. Add a Computed Property
extension Double {
    var kilogram:Double{
        self*1000
    }
}
print(3.5.kilogram)


//3. Add an Initializer
struct Rectangle {
    var width:Double
    var height:Double
}
extension Rectangle{
    init(side:Double){
        self.init(width: side, height: side)
    }
}
let square = Rectangle(side: 8)
print(square)


//4. Add Protocol Conformance
struct Student{
    var name:String
}
extension Student : CustomStringConvertible{
    var description: String{
        "Student: \(name)"
    }
}
print(Student(name:"Ajay"))


//5. Add a Subscript
extension String{
    subscript(index : Int) -> Character {
        self[self.index(self.startIndex, offsetBy: index)]
    }
}
print("Swift"[2])


//6. Access the nested type
extension Int {
    enum Kind {
        case negative
        case zero
        case positive
    }
    var kind: Kind {
        if self == 0 {
            return .zero
        } else if self > 0 {
            return .positive
        } else {
            return .negative
        }
    }
}
let number = -10
print(number.kind)
