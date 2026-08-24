import UIKit

//array
let arr = [1,2,4,6,9]
print(arr)

var threeDoubles = Array(repeating: 1.1, count: 3)
print(threeDoubles)





//set
let colors = Set(["red", "green","black", "blue"])
let colors2 = Set(["red", "green", "blue", "red", "blue","red"])
print(colors2)
//colors2.insert("black")
var list = Set(["red", "green","black", "blue"])
list.insert("yellow")
print(list)

//tuple
var name = (first: "meghana",last:"gs")
print(name.0)
print(name.1)
var names = ("meghana","yashu","hruthik")
print(names.1)
print(name.first)
print(names.2)

//dict
let height = ["1":1.1,"2":2.2,"3":3.3]
print(height["1"] ?? "unknown")
height["1"]

//default
let results = [
    "english": 100,
    "french": 85,
    "geography": 75
]
let res = results["english", default: 0]
let resu = results["geo", default: 0]
print(res)
print(resu)

//empty collection
var nums = [String: String]()
nums["1"]="one"
print(nums)

var dict = Dictionary<String,Int>()
dict["1"]=1
print(dict)

var char = Set<Character>()
    print("\(char)")
char.insert("h")
print(char)

//enums
enum pf: Int{
    case pass
    case fail
}

let a = pf.pass
print(a)
let fail = pf(rawValue:1)
print(fail ?? "Unknow")

//arthmetic operators
let c = 10
let b = 20
let t1 = c+b
print(t1)
let t2 = c-b
print(t2)
let t3 = c*b
print(t3)
let t4 = b/c
print(t4)
let t5 = c%b
print(t5)



