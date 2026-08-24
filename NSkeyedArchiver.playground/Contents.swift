import UIKit
import Foundation

class Student : NSObject,NSSecureCoding {
    var name :String
    var age : Int
    init(name:String ,age:Int){
        self.name = name
        self.age = age
    }
    static var supportsSecureCoding: Bool {
        return true
    }
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(age, forKey: "age")
    }
    required init?(coder: NSCoder) {
        self.name = coder.decodeObject(
            of: NSString.self,
            forKey: "name"
        ) as String? ?? ""
        self.age = coder.decodeInteger(forKey: "age")
    }
}

//Archiving the Object
let student = Student(name: "meghana", age: 24)
do{
    let data = try NSKeyedArchiver.archivedData(withRootObject: student, requiringSecureCoding: true)
    print(data)
}catch{
    print(error)
}


//Saving the archived data to a file
let student1 = Student(name: "yashu", age: 24)
do{
    let data = try NSKeyedArchiver.archivedData(withRootObject: student1, requiringSecureCoding: true)
    let url = FileManager.default
        .urls(for: .documentDirectory, in: .userDomainMask)[0]
        .appendingPathComponent("student.data")
    try data.write(to: url)
    print("saved successfully")
    
}catch{
    print("Error",error)
}

//Unarchiving/Reading the object
do{
    let url = FileManager.default
        .urls(for: .documentDirectory, in: .userDomainMask)[0]
        .appendingPathComponent("student.data")
    let data = try Data(contentsOf: url)
    let student = try NSKeyedUnarchiver.unarchivedObject(ofClass: Student.self, from: data)
    print(student? .name ?? "")
    print(student? .age ?? 0)
}catch{
    print("Error",error)
}

let randomFilename1 = UUID().uuidString
let fullPath1 = getDocumentsDirectory().appendingPathComponent(randomFilename1)
do{
    let data = try NSKeyedArchiver.archivedData(withRootObject: student, requiringSecureCoding: true)
    try data.write(to: fullPath1)
}catch{
    print("couldn't write file")
}


func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}
do {
    let data = try NSKeyedArchiver.archivedData(
        withRootObject: student,
        requiringSecureCoding: true
    )
    try data.write(to: fullPath1)
    print("Student saved")
    print("File path: \(fullPath1)")
} catch {
    print("Couldn't write file: \(error)")
}


