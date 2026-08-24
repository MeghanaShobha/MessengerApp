import UIKit

//difference between the var and const
/*
 | Feature           | Variable (`var`)   | Constant (`let`)         |
 | ----------------- | ------------------ | ------------------------ |
 | Declaration       | `var`              | `let`                    |
 | Value can change? | ✅ Yes              | ❌ No                     |
 | Memory            | Mutable            | Immutable                |
 | Best used for     | Values that change | Values that never change |
*/
var hi = 12
print(hi)
hi = 98
print(hi)

let name = "Meghaana"
//name = "Megha"
//
//var name1
//name = "meghana"

let name2: String
name2 = "Megha"
var age : Int
age = 24

var name3:String
name3 = "Megha"
//name3 = 23
//age = "yashu"


//Float and Double. -apple will choose the Double because it as highest accuracy.
var latitude: Double
latitude = 36.166667

var longitude: Float
longitude = -86.783333


var longitude1: Float
longitude1 = -86.783333
longitude1 = -186.783333
longitude1 = -1286.783333
longitude1 = -12386.783333
longitude1 = -123486.783333
longitude1 = -1234586.783333


var longitude2: Double
longitude2 = -86.783333
longitude2 = -186.783333
longitude2 = -1286.783333
longitude2 = -12386.783333
longitude2 = -123486.783333
longitude2 = -1234586.783333

var value = "Hruthik"
var value1:String = "Hruthik"
var value2:String? = nil
var value3:[String]=["a","b","c","d"]


class hii{
    let name:String
    var age:Int
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}
let hello = hii(name:"A",age:43)
//name = "sjkd"
age = 3289


var a = 13
a += 2
a -= 1
a *= 6
a /= 2
print(a)

let b = 123
//b += 2

var c = 12
var d = 234
var e = c + d


var name4 = "Abdual"
var name5 = "kalam"
var name1 = name4 + " " + name5
print(name1)

var f = 1.1
var g = 2.2
var h = f+g

h < 3
h > 3
h <= 4
h >= 4

var i = "Meghana"
i ==  "meghana" // Case-sensitive
i == "Meghana"

var j = true
j
!j

var k = "Meghana"
k == "Meghana"
k != "Meghana"

var l = "Meghana"
print("my name is \(l)")
print("my name is " + l)

//my mother is 2 times me i am 24 years
var m = 24
print("my age is \(m) and my mother age is \(m * 2)")


var n = ["A","B","C","D","E"]
type(of: n)
n[0]
n[4]
//n[5] //out of range

var songs = ["Shake it Off", "You Belong with Me", "Back to December"]
type(of: songs)

var o :[Any] = ["a","b","c","d","R",3]

var p:[String]
//p[0] = "aaa"

//var q :[String] = []
//q[0] = "AAA"  // it crash the code
//print(q)


var s1 = ["Shake it Off", "You Belong with Me", "Love Story"]
var s2 = ["Today was a Fairytale", "Welcome to New York", "Fifteen"]
var both = s1 + s2
both += ["Everything has Changed"]

var person = ["first": "Taylor", "middle": "Alison", "last": "Swift", "month": "December", "website": "taylorswift.com"]
person["middle"]
person["month"]


var action :String
var person1 = "hater"
if person1 == "hater"{
    action = "hate"
}


var action1 :String
var person4 = "hater"
if person4 == "hater"{
    action = "hater"
}else if person4 == "player"{
    action = "play"
}else{
    action = "cruise"
}

var action2:String
var stayOut = true
var ntgInbook = true
if stayOut && ntgInbook{
    action2 = "cruise"
}
if !stayOut && !ntgInbook{
    action2 = "playyyy"
}


print("1*1=\(1*1)")
print("1*2=\(1*2)")
print("1*3=\(1*3)")
print("1*4=\(1*4)")
print("1*5=\(1*5)")
print("1*6=\(1*6)")
print("1*7=\(1*7)")
print("1*8=\(1*8)")
print("1*9=\(1*9)")
print("1*10=\(1*10)")


for i in 1...5{
    for j in 1...10{
        print("\(i)*\(j) = \(i*j)")
    }
}

var str = "woof"
for _ in 1...5{
    str += " fake"
}
print(str)


print("count says")
for num in 1..<5{
    print(num)
}

var people = ["players","haters","heartbreakers","fakers"]
var actions = ["play","hate","break","fake"]
for i in 0...3{
    print("\(people[i]) gonna \(actions[i])")
}
for j in 0..<people.count{
    print("\(people[j]) gonna \(actions[j])")
}


for k in 0..<people.count{
    var str = " \(people[k]) gonna"
    for _ in 1...5{
        str += " \(actions[k])"
    }
    print(str)
}
    
var counter = 0
while true {
    print("count is now \(counter)")
    counter += 1
    if counter == 556{
        break
    }
}


var song1 =  ["Shake it Off", "You Belong with Me", "Look What You Made Me Do"]
for song in song1{
    if song == "You Belong with Me"{
        continue
    }
    print("My fav Song is \(song) ")
}

let liveAlbums = 2
switch liveAlbums{
case 0:
    print("your just started")
case 1:
    print("You just released iTunes Live From SoHo")
case 2:
    print("You just released Speak Now World Tour")
default:
    print("Have you done something new?")
}


let studioAlbums = 3
switch studioAlbums{
case 0...1:
    print("You're just starting out")
case 2...3:
    print("You're a rising star")
case 4...5:
    print("You're world famous!")
default:
    print("Have you done something new?")
}

