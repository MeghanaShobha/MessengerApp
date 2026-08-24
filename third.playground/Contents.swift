import UIKit


let num  = 465
let ismultiple = num.isMultiple(of: 7)
print(ismultiple)
let nums = 105
let ismultiples = nums.isMultiple(of: 7)
print(ismultiples)

//operator overloading
let a = 45
let b = 45+45
print(b)
let c = a+80
print(c)
let d = "hi i am "
let e = d+"meghana"
print(e)
let f = ["hello","hi","hey"]
let g = ["hello","hi","hey"]
let h = f+g
print(h)

//compound operators
var score = 95
score -= 5
print(score)
var hi = "my name is megha "
hi += "you are? "
print(hi)
var aa = 10
aa *= 5
print(aa)
//let bb = 20  //let is fixed
//bb *= 2
//print(bb)

//comparison operators
let cc = 100
let dd = 200
let ee = (cc == dd)
print(ee)
let ff = (cc != dd)
print(ff)
let gg = (cc > dd)
print(gg)
let hh = (cc < dd)
print(hh)
let ii = (cc >= dd)
print(ii)
let jj = (cc <= dd)
print(jj)
let kk = (cc >= 100) && (cc <= 200)
print(kk)
let ll = (cc >= 100) || (cc <= 200)
print(ll)
let mm = !(cc >= 100)
print(mm)
let nn = !(cc <= 200)
print(nn)
let oo = "hi"
let pp = "hello"
let qq = (oo == pp)
print(qq)
let rr = (oo < pp)//"hi"  i has value grater than e
print(rr)
let ss = (oo > pp)
print(ss)


//enums things
enum size: Equatable{
    case small
    case medium
    case large
}
print(size.small == size.large)
print(size.small != size.large)

enum Size: Comparable {
    case small
    case medium
    case large
}
print(Size.small == Size.small)   // true
print(Size.small < Size.large)    // true
print(Size.large > Size.medium)   // true

//| Protocol                  | Purpose                                       | Example             |
//| ------------------------- | --------------------------------------------- | ------------------- |
//| `Equatable`               | Compare for equality (`==`, `!=`)             | `a == b`            |
//| `Comparable`              | Compare order (`<`, `>`, `<=`, `>=`)          | `a < b`             |
//| `Hashable`                | Use as dictionary keys or in sets             | `Set`, `Dictionary` |
//| `Codable`                 | Encode and decode data (JSON, Property Lists) | JSON parsing        |
//| `Identifiable`            | Give each object a unique identity            | SwiftUI `List`      |
//| `CaseIterable`            | Access all enum cases                         | `Enum.allCases`     |
//| `CustomStringConvertible` | Customize what `print()` displays             | `description`       |
//| `RawRepresentable`        | Give enum cases raw values                    | `enum Status: Int`  |


let tt = 20
let uu = 300
if tt + uu == 50{
    print("the number is fifty")
}else if tt+uu == 500{
    print("it is five hundred")
}else{
    print("it is not fifty or five hundred")
}


//comining operators
//let kk = (cc >= 100) && (cc <= 200)
//print(kk)
//let ll = (cc >= 100) || (cc <= 200)
//print(ll)


//switch case
//as this things inside that
//interval matching
//tuples
//value binding
//where
//compound cases
//patterns
let weather = "sunny"
switch weather{
case "rainy":
    print("bring umbrella")
case "snow":
    print("Wrap up warm")
case "sunny":
    print("Wear sunscreen")
default:
    print("Enjoy your day!")
}

//interval matching
let scores = 87

switch scores {
case 90...100:
    print("A")
case 80..<90:
    print("B")
case 70..<80:
    print("C")
default:
    print("Fail")
}

//tuple matching
let point = (1, 0)
switch point {
case (0, _):
    print("Origin")
case (_, 0):
    print("On X-axis")
case (0, 0):
    print("On Y-axis")
default:
    print("Somewhere else")
}

//value binding
let (x,y) = (0,0)
switch (x,y) {
case (let x ,0):
    print("x: \(x)")
case (0,let y):
    print("y: \(y)")
default:
    print("somewhere else")
}

//where
let (gs,sg) = (1,-2)
switch (gs,sg) {
case let(gs,sg) where gs == sg:
    print("both are equal")
case let(gs,sg) where gs == -sg:
    print("gs is greater then that")
case let(gs,sg) where -gs == sg:
    print("sg is more than that")
case let(gs,sg):
    print("non of this")
}
    
//compound cases
let somechar : Character = "e"
switch somechar{
case "a","e","i","o","u":
    print("vowel")
default:
    print("consonant")
}

//patterns
let somepoint = (12,100)
if case(let x,100) = somepoint{
    print("found the point y=100 line at \(x)")
}




//range operators
//..< it excludes the last value
//... it inclues the last value too

let sc = 80

switch sc{
case 0..<50:
    print(" it is less than fifty")
case 50...80:
    print("it is to good")
default:
    print("its great")
}


let names = ["Piper", "Alex", "Suzanne", "Gloria"]
print(names[0..<2])
print(names[0...3])
