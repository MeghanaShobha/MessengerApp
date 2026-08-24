import UIKit

/*Property List (Plist)
 A Property List, or .plist, is a file format used by Apple platforms to store structured data as key-value pairs.
 You will commonly see .plist files in Xcode projects.
 */
//for example
//<key>name</key>
//<string>Meghana</string>
//
//<key>age</key>
//<integer>24</integer>
//
//<key>isLoggedIn</key>
//<true/>


/*2. .plist vs UserDefaults
 They are related, but not the same thing.
 UserDefaults
 Used for small app preferences:*/
let defaults = UserDefaults.standard
defaults.set("Meghana", forKey: "name")
defaults.set(true, forKey: "isLoggedIn")

/*.plist
 A plist is an actual file containing structured data.

 For example:
 MyData.plist
 │
 ├── name
 ├── age
 ├── gender
 └── isActive
 */

if let path = Bundle.main.path(forResource: "MyData", ofType: "plist") {
    print(path)
}
//Bundle.main means:
//Look inside the application's bundled resources.
    

//4. Reading plist as a Dictionary
if let path = Bundle.main.path(forResource: "MyData", ofType: "plist") {
    let data = NSDictionary(contentsOfFile: path)
    print(data!)
}

//5. Modern approach: PropertyListDecoder
//For structured data, Codable is a better approach.
struct User: Codable {
    let name: String
    let age: Int
}
let decoder = PropertyListDecoder()

//PropertyListencoder
let user = User(name: "Meghana", age: 24)
let encoder = PropertyListEncoder()
if let data = try? encoder.encode(user) {
    print(data)
}
//let encoder = JSONEncoder
//let decoder = JSONDecoder
/*
 | JSON                             | Plist                                         |
 | -------------------------------- | --------------------------------------------- |
 | JavaScript Object Notation       | Property List                                 |
 | Very common for APIs             | Very common in Apple ecosystem                |
 | Human-readable                   | Can be XML or binary                          |
 | Common for network communication | Common for app configuration/local Apple data |
 | `JSONEncoder`                    | `PropertyListEncoder`                         |
 | `JSONDecoder`                    | `PropertyListDecoder`                         |
 | `.json`                          | `.plist`                                      |
*/

let fileManager = FileManager.default
let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
let path = documentDirectory.appending("/example.plist")

if (!fileManager.fileExists(atPath: path)){
    //here is where we are going to create the plist file
}
let dicContent:[String: String] = ["Alabama": "Montgomery", "Alaska":"Juneau","Arizona":"Phoenix"]
let plistContent = NSDictionary(dictionary: dicContent)
let success:Bool = plistContent.write(toFile: path, atomically: true)
if success{
    print("file has been created!")
}else{
    print("unable to create the file")
}
func pListCreation(){
    let fileManager = FileManager.default
    let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
    let path = documentDirectory.appending("/example.plist")
    
    if (!fileManager.fileExists(atPath: path)){
        let dicContent:[String: String] = ["Alabama": "Montgomery", "Alaska":"Juneau","Arizona":"Phoenix"]
        let plistContent = NSDictionary(dictionary: dicContent)
        let success:Bool = plistContent.write(toFile: path, atomically: true)
        if success{
            print("file has been created!")
        }else{
            print("unable to create the file")
        }
    }else{
        print("file already exists")
    }
}



let fileManager1 = FileManager.default
let documentDirectory1 = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
    let path1 = documentDirectory.appending("/example.plist")
if (!fileManager.fileExists(atPath: path)) {
            /*here is where we are going to create the plist file*/
    }
let dicContent1:[String: String] = ["Alabama": "Montgomery", "Alaska":"Juneau","Arizona":"Phoenix"]
let plistContent1 = NSDictionary(dictionary: dicContent)
let success1:Bool = plistContent.write(toFile: path, atomically: true)
if success {
    print("file has been created!")
}else{
    print("unable to create the file")
}
func pListCreation1() {
    let fileManager = FileManager.default
    let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
    let path = documentDirectory.appending("/example.plist")
    
    if (!fileManager.fileExists(atPath: path)) {
        let dicContent:[String: String] = ["Alabama": "Montgomery", "Alaska":"Juneau","Arizona":"Phoenix"]
        let plistContent = NSDictionary(dictionary: dicContent)
        let success:Bool = plistContent.write(toFile: path, atomically: true)
        if success {
            print("file has been created!")
        }else{
            print("unable to create the file")
        }
        
    }else{
        print("file already exist")
    }
}

/*
 | Feature             | `UserDefaults`                             | `.plist`                                 |
 | ------------------- | ------------------------------------------ | ---------------------------------------- |
 | What is it?         | Key-value storage API                      | File format                              |
 | Main purpose        | User preferences/settings                  | Configuration/static structured data     |
 | Usually persistent? | ✅ Yes                                      | ✅ Yes if stored as a file                |
 | Typical example     | Dark mode, login flag                      | App configuration, bundled data          |
 | File extension      | Not something you normally manage directly | `.plist`                                 |
 | API                 | `UserDefaults`                             | `PropertyListEncoder/Decoder`, file APIs |
 | Can use `Codable`?  | Indirectly, by storing encoded `Data`      | ✅ Yes                                    |
 | App can modify?     | ✅ Yes                                      | ✅ Depends on where the plist is located  |
 | Best for            | Small settings                             | Structured configuration/data            |
*/


//if you want to create a plist using swift
struct User1 : Codable {
    let name :String
    let age : Int
    let isActive : Bool
}
let user1 = User1(
    name :"Meghana",
    age : 24,
    isActive : true
)
let encoder1 = PropertyListEncoder()
if let data = try? encoder.encode(user1){
    print(data)
}
    