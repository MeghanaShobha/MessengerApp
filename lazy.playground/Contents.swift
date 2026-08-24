import UIKit


//lazy -A lazy variable in Swift is a stored property whose value is not created until it is used for the first time. Instead of initializing the property when an instance is created, Swift delays its initialization until the property is accessed.

func fib(of num : Int)-> Int {
    if num < 2 {
        return num
    }
    return fib(of: num-1) + fib(of: num-2)
}

struct Person{
    var age = 16
    lazy var fibage:Int = {
        fib(of: self.age)
    }()
    func fibonacci(of num:Int)->Int{
        if num < 2{
            return num
        }else{
            return fibonacci(of: num - 1) + fibonacci(of: num - 2)
        }
    }
}

func loadData()->[String]{
    print("data...")
    return ["i hate u"]
}
class Datamanager{
    lazy var data = loadData()
    func loaddata()->[String]{
        print("laoding the data...")
        return ["a","b","c"]
    }
}
let manager = Datamanager()
print(manager)

print(manager.data)


class User{
    var name = "Meghana"
    lazy var greeting = {
        return "hello \(name)"
    }()
}
let user  = User()
print(user)
print(user.greeting)



func ImageProcess() -> String{
    return "ok"
}
class PhotoEditer{
    lazy var imageProcess = ImageProcess()
    func editPhoto(){
        print("Edited pic")
    }
}
let p = PhotoEditer()
print(p)
print(p.imageProcess)


//
let numbers = Array(1...1_000_000)
let result = numbers
    .filter { $0.isMultiple(of: 2) }
    .map { $0 * 2 }
struct Person1 {
    let name: String
    let age: Int
}
struct PeopleViewModel {
    let people: [Person1]
    lazy var oldest: Person1? = {
        print("Lazy var oldest initialized")
        return people.max(by: { $0.age < $1.age })
    }()
    init(people: [Person1]) {
        self.people = people
        print("View model initialized")
    }
}
var viewModel = PeopleViewModel(people: [
    Person1(name: "Antoine", age: 30),
    Person1(name: "Jaap", age: 3),
    Person1(name: "Lady", age: 3),
    Person1(name: "Maaike", age: 27)
])
if let oldestPerson = viewModel.oldest {
    print("Oldest person:")
    print("Name: \(oldestPerson.name)")
    print("Age: \(oldestPerson.age)")
} else {
    print("No people found.")
}


class Database{
    init(){
        print("database init")
    }
    deinit{
        print("database deinit")
    }
}
class App{
    lazy var database = Database()
    init(){
        print("App init")
    }
    deinit{
        print("App destroy")
    }
}
var app:App? = App()
print("hi")
//print(app!.database)
print("bye")
app = nil


struct FixedLengthRenge {
    var StartIndex: Int
    var Length: Int
}
var range = FixedLengthRenge(StartIndex: 0, Length: 3)
range.StartIndex = 6
print(range.StartIndex)


class DataImporter{
    var filename = "data.text"
}
class Datamanager1{
    lazy var importer = DataImporter()
    var  data: [String] = []
}
let m = Datamanager1()
m.data.append("SomeData")
m.data.append("DATAstore")
print("m= ",m.data[0])
print("m1= ",m.data.last)

