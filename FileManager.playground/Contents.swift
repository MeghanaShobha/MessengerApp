import UIKit

/*Understanding FileManager and File Paths in Swift
 FileManager is Apple's API for working with the file system.

You can use it to:
 Create files and folders
 Read files
 Write files
 Copy files
 Move files
 Delete files
 Check whether a file exists
 Get paths to app directories*/

//let fileManager = FileManager.default
let fileManger = FileManager.default
if fileManger.fileExists(atPath: "/Users/Meghana/Desktop/study.txt") {
    print("File exists")
}

//Absolute path - An absolute path starts from the root /.
//App directories - For an iOS/macOS app, you normally ask the system for the appropriate directory.
let fileManager = FileManager.default
let documentsURL = fileManager.urls(
    for: .documentDirectory,
    in: .userDomainMask
).first!
print(documentsURL)

let documentsURL1 = FileManager.default.urls(
    for: .documentDirectory,
    in: .userDomainMask
).first!
let fileURL = documentsURL1.appendingPathComponent("study.txt")
print(fileURL)

//Creating a file
let fileManager2 = FileManager.default
let documentsURL2 = fileManager2.urls(
    for: .documentDirectory,
    in: .userDomainMask
).first!

let fileURL2 = documentsURL2.appendingPathComponent("study.txt")
let text = "Hello Swift"
fileManager2.createFile(
    atPath: fileURL2.path,
    contents: text.data(using: .utf8)
)

// Reading a file
if let text = try? String(contentsOf: fileURL, encoding: .utf8) {
    print(text)
}

//Writing to a file
let text1 = "Hello Swift"
try? text1.write(
    to: fileURL,
    atomically: true,
    encoding: .utf8
)

// Check whether a file exists
if FileManager.default.fileExists(atPath: fileURL.path) {
    print("File exists")
} else {
    print("File does not exist")
}

//Create a folder
let folderURL = documentsURL.appendingPathComponent("MyFolder")
try? FileManager.default.createDirectory(
    at: folderURL,
    withIntermediateDirectories: true
)

//Delete a file
try? FileManager.default.removeItem(at: fileURL)


//Copy a file
let copyURL = documentsURL.appendingPathComponent("study-copy.txt")
try? FileManager.default.copyItem(
    at: fileURL,
    to: copyURL
)

//Move a file
let newURL = documentsURL.appendingPathComponent("newStudy.txt")
try? FileManager.default.moveItem(
    at: fileURL,
    to: newURL
)

//Important directory types
//.documentDirectory
//.libraryDirectory
//.cachesDirectory
//.temporaryDirectory


//writing to a file
import Foundation
let fileManager1 = FileManager.default
let filepath = "Myfile.txt"
let fileContent  = "hello,World!"
if let data = fileContent.data(using: .utf8){
    let success = fileManger.createFile(atPath:"\(filepath)" , contents: data,attributes :nil)
    if success {
        print("file created and data written successfully")
    }else{
        print("Failed to create file")
    }
}else{
    print("Failed to convent string to data ")
}


//let fileManager3 = FileManager.default
//let sourcePath = "Myfile.txt"
//let destinationPath = "newFile.txt"
//let fileContent2 = "Hello,Word"
//if let data = fileContent2.data(using: .utf8){
//    let success = fileManager3.createFile(atPath: destinationPath, contents: data, attributes: nil)
//    if success {
//        print("file created and data written successfully")
//    }else{
//        print("Failed to create file")
//    }
//}
//do{
//    try fileManager3.copyItem(
//            at: URL(fileURLWithPath: sourcePath),
//            to: URL(fileURLWithPath: destinationPath)
//        )
//    print("File copied successfully")
//}catch {
//    print("Error,\(error)")
//}



//writing the conternts in the file and creating
let fileManager3 = FileManager.default
let documentsURL3 = fileManager3.urls(
    for: .documentDirectory,
    in: .userDomainMask
).first!
let sourceURL = documentsURL3.appendingPathComponent("Myfile.txt")
let fileContent3 = "hello, World!"
if let data = fileContent3.data(using: .utf8) {
    let success = fileManager3.createFile(
        atPath: sourceURL.path,
        contents: data,
        attributes: nil
    )
    if success {
        print("File created and data written successfully")
    } else {
        print("Failed to create file")
    }
} else {
    print("Failed to convert string to data")
}


// Copy Myfile.txt

let destinationURL4 = documentsURL.appendingPathComponent("newFile.txt")
do {
    try fileManager3.copyItem(
        at: sourceURL,
        to: destinationURL4
    )
    print("File copied successfully")
    
} catch {
    print("Error: \(error)")
}

//moving the file
if let fileData = fileManager3.contents(atPath: destinationURL4.path)
{
    if let fileContentString = String(data:fileData,encoding: .utf8){
        print("File content is file 2")
        print(fileContentString)
    }
}else{
    print("Failed to read file")
}


//reading the dat from the file
if let fileData = fileManager3.contents(atPath: destinationURL4.path){
    if let fileContentString = String(data:fileData,encoding: .utf8){
        print("file contents in file2")
        print("file Content String")
    }
}else{
    print("failedd to read file")
}


//Deleting the file
do{
    try fileManager3.removeItem(at: destinationURL4)
    print("file deleting successfully")
}catch{
    print("Error:\(error)")
}

//recheck idf the file is deleted or not
if fileManager3.fileExists(atPath: destinationURL4.path){
    print("File exists")
}else{
    print("File doesnot exists")
}


//main bundle directory
if let burl = Bundle.main.resourceURL{
    print("main Bundle dict : \(burl)")
}else{
    print("unable to access main bundle directory")
}

//Documents Directory
if let documentsDirectory = FileManager.default.urls(
    for: .documentDirectory,
    in: .userDomainMask
).first{
    print("Document Direcory :\(documentsDirectory)")
}else{
    print("unable to access Document Directory")
}


//library Direcorty
if let libraryDirectory = FileManager.default.urls(
    for: .libraryDirectory,
    in: .userDomainMask).first{
    print("library Directory :\(libraryDirectory)")
}else{
    print("inable to access library directory")
}

//caches Directory
if let cacheDirectory = FileManager.default.urls(
    for: .cachesDirectory,
    in: .userDomainMask).first{
    print("caches Directory :\(cacheDirectory)")
}else{
    print("inable to access caches directory")
}

//temporary Directory
let temporaryDirectory = FileManager.default.temporaryDirectory
print("Temporary Directory : \(temporaryDirectory)")
