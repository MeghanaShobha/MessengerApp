import UIKit


var score = 10 {
    willSet {
        print("Score is about to change from \(score) to \(newValue)")
    }
}
score = 20  //Score is about to change from 10 to 20

var score1 = 10 {
    didSet {
        print("Score changed from \(oldValue) to \(score1)")
    }
}
score1 = 20  //Score changed from 10 to 20



struct person{
    var clothes: String
    var shoes: String
    func describe() -> String {
        return "wearing \(clothes) and \(shoes)"
    }
}
let t = person(clothes: "jacket", shoes: "sneakers")
let o = person(clothes: "short skirt", shoes: "high heels")
t.describe()+"\n"+o.describe()

struct Person{
    var clothes: String{
        willSet{
            updateUI(msg: "I'm changing from \(clothes) to \(newValue)")
        }
        didSet{
            updateUI(msg: "I just changed from \(oldValue) to \(clothes)")
        }
    }
}
func updateUI(msg: String){
    print(msg)
}
var tt = Person(clothes: "T-shirt")
tt.clothes = "short skirts"


struct person1{
    var age:Int
    var ageInDogYears: Int {
        get{
            return age * 7
        }
    }
}
var fan = person1(age: 20)
print(fan.ageInDogYears)

struct TaylorFan{
    static let favsong = "Perfect"
    var name : String
    var age :Int
}
let fan1 = TaylorFan(name: "Jack", age: 20)
print(TaylorFan.favsong)

class TaylorFan1{
    private var name: String?
}
let a = TaylorFan1()
//a.name = "Jack" // private value we cant access


class Album{
    var songs: String
    init(songs: String){
        self.songs = songs
    }
    func getPerformance() -> String {
            return "The album \(songs) sold lots"
        }
}
class StudioAlbum:Album{
    var studio:String
    init(songs:String,studio:String){
        self.studio = studio
        super.init(songs: songs)
    }
    override func getPerformance() -> String {
            return "The studio album \(songs) sold lots"
        }
}
class liveAlbum:Album{
    var location:String
    init(song:String,location:String){
        self.location = location
        super.init(songs: song)
    }
    override func getPerformance() -> String {
            return "The live album \(songs) sold lots"
        }
}

var iTunesLive = Album(songs: "iTunes Live from SoHo")
var fearless = StudioAlbum(songs:"Speak Now", studio: "Aimeeland Studio")
var TunesLive = liveAlbum(song: "iTunes Live from SoHo", location: "New York")
var albums : [Album] = [iTunesLive,fearless,TunesLive]
for album in albums{
    print(album.getPerformance())
}

for album in albums {
    let studioAlbum = album as? StudioAlbum
}

for album in albums {
    print(album.getPerformance())
    if let studioAlbum = album as? StudioAlbum{
        print(studioAlbum.studio)
    }else if let liveAlbum = album as? liveAlbum{
        print(liveAlbum.location)
    }
}
var taylorSwift = StudioAlbum(songs: "Taylor Swift", studio: "The Castles Studios")
var fearles = StudioAlbum(songs:"Speak now", studio: "Aimeeland Studio")
var allalbums :[Album] = [taylorSwift, fearless]
//for album in albums {
//    let studioAlbum = album as! StudioAlbum   //crash the code
//    print(studioAlbum.studio)
//}

//for album in albums as! [StudioAlbum]{
//    print(album.studio)
//}

for album in albums as? [liveAlbum] ?? [liveAlbum]() {
    print(album.location)
}


//let number = 5
//let text = number as! String

let number1 = 7
let text1 = String(number1)
print(text1)

import SwiftUI
let message = "ButtonPressed"
Button("Press Me", action: {
    print(message)
})


let message1 = "Button Passed"
Button("Press Me") {
    print(message1)
}

Button{
    print("the button was pressed")
} label: {
    Image("press me")
}



//trimming characters   -> trimmingCharacters(in:)
let text = "  hello, swift !!!  "
let trimmed = text.trimmingCharacters(in: .whitespaces) // it removes only first and last spaces
print(trimmed)


//remove the specific char
let s = "***Welcome***"
let trimmed1 = s.trimmingCharacters(in: CharacterSet(charactersIn: "*"))
print(trimmed1)


//components(separatedBy:)
let text2 = " hello, swift !!! "
let words = text2.components(separatedBy: " ")
print(words)


/*
 | `components(separatedBy:)`    | `split(separator:)`                                           |
 | ----------------------------- | ------------------------------------------------------------- |
 | Returns `[String]`            | Returns `[Substring]`                                         |
 | Keeps empty strings           | Ignores empty subsequences by default                         |
 | Part of `Foundation`          | Native Swift API                                              |
 | Can separate using a `String` | Separates using a single `Character` (or predicate overloads) |
*/


let text4 = "A,,B"
// components
print(text4.components(separatedBy: ","))
// ["A", "", "B"]

// split
print(text4.split(separator: ","))
// ["A", "B"]


/*
 CustomStringConvertible – Human-readable description (print()).
 CustomDebugStringConvertible – Custom description for debugging (debugPrint()).
 */



// CustomDebugStringConvertible
struct Employee:CustomDebugStringConvertible{
    let id :Int
    var debugDescription: String{
        return "id: \(id)"
    }
    
}
let emp = Employee(id:101)
debugPrint(emp)
