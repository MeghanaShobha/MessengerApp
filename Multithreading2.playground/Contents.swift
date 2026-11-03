import UIKit
import Foundation
import SwiftUI
import PlaygroundSupport

class CustomThread: Thread {
    override func start() {
        print("Running on Custom Thread", self.debugDescription)
        super.start()
    }
    override func main() {
        print("Main called for", self.debugDescription)
    }
}
let thread1 = CustomThread()
thread1.start()
var flag1 = false
var flag2 = false
let id = "1234"
func fetchUserProfileDetails(
    id: String,
    completion: @escaping () -> Void
) {
    DispatchQueue.global().async {
        sleep(2)
        print("User profile details fetched")
        completion()
    }
}
func fetchUserPublicDetails(
    id: String,
    completion: @escaping () -> Void
) {
    DispatchQueue.global().async {
        sleep(3)
        print("User public details fetched")
        completion()
    }
}
func startFetch() {
    startLoader()
    fetchUserProfileDetails(id: id) {
        DispatchQueue.main.async {
            flag1 = true
            hideLoaderIfShould()
        }
    }
    fetchUserPublicDetails(id: id) {
        DispatchQueue.main.async {
            flag2 = true
            hideLoaderIfShould()
        }
    }
}
func startLoader() {
    print("Loader shown")
}
@MainActor func hideLoaderIfShould() {
    if flag1 && flag2 {
        print("Loader hidden")
    }
}
startFetch()




func login(
    userId: String,
    password: String,
    completion: @escaping() -> Void
) {
    DispatchQueue.global().async {
        sleep(2)
        print("Login completed")
        completion()
    }
}
func fetchUserDetail(
    id: String,
    completion: @escaping() -> Void
) {
    DispatchQueue.global().async {
        sleep(2)
        print("User details fetched")
        completion()
    }
}
login(userId: "1234", password: "password") {
    
    fetchUserDetail(id: "1234") {
        
        DispatchQueue.main.async {
            print("Execution completed")
        }
    }
}
let dispatchGroup = DispatchGroup()
dispatchGroup.enter()
login(userId: "1234", password: "password") {
    dispatchGroup.leave()
}
dispatchGroup.notify(queue: .global()) {
    dispatchGroup.enter()
    fetchUserDetail(id: "1234") {
        dispatchGroup.leave()
    }
    dispatchGroup.notify(queue: .main) {
        print("Execution completed")
    }
}

class Loader {
    func show() {
        print("Loader shown")
    }
    func hide() {
        print("Loader hidden")
    }
}
let loader = Loader()
let id1 = "1234"
let dispatchGroup1 = DispatchGroup()

@MainActor func startFetch1() {
    loader.show()
    dispatchGroup.enter()
    fetchUserProfileDetails(id: id) {
        dispatchGroup.leave()
    }
    dispatchGroup.enter()
    fetchUserPublicDetails(id: id) {
        dispatchGroup.leave()
    }
    dispatchGroup.notify(queue: .main) {
        print("Execution completed")
        loader.hide()
    }
}


let operationQueue = OperationQueue()
let operation1  = BlockOperation {
    print("Operation 1")
}
let operation2  = BlockOperation {
    print("Operation2")
}
operation2.addDependency(operation1)
operationQueue.addOperation(operation1)
operationQueue.addOperation(operation2)


// Using async/await
func someAsyncOperation() async {
    print("Async operation started")
    try? await Task.sleep(for: .seconds(2))
    print("Async operation completed")
}
func fetchUser1() async {
    print("Start")
    await someAsyncOperation()
    print("Finished")
}
Task {
    print("Task started")
    await fetchUser1()
    print("Task finished")
}

//Task
Task {
    print("Task started")
        await fetchUser1()
    print("Task finished")
    
    func fetchPosts1() async -> [String] {
        print("Fetching posts...")
        try? await Task.sleep(for: .seconds(2))
        print("Posts fetched")
        return [
            "Post 1",
            "Post 2",
            "Post 3"
        ]
    }
    //async let
    async let user = fetchUser1()
    async let posts = fetchPosts1()
    let result = try await (user, posts)
    
    
    //Actor
    //Actors protect mutable shared state from data races.
    actor BankAccount1 {
        private var balance = 0
        func deposit(_ amount: Int) {
            balance += amount
        }
        func getBalance() -> Int {
            balance
        }
    }
    
    
    //check for the current thread space
    //let current = Thread.current
    //print("Current thread:", current,current.stackSize)
    let t = Thread()
    t.name = "Secondary"
    print("Secondary thread with default size ",t,t.stackSize)
    let t1 = Thread()
    t1.name = "Secondary1"
    t.stackSize = 4096*512
    print("Secondary thread",t1,t1.stackSize)
    
    class ThreadTest {
        func createThread() {
            Thread.detachNewThreadSelector(
                #selector(threadWork),
                toTarget: self,
                with: nil
            )
        }
        @objc func threadWork() {
            print("Thread loop running")
            print("Current thread:", Thread.current)
            for i in 1...5 {
                print("Thread running: \(i)")
                Thread.sleep(forTimeInterval: 1)
            }
            print("Thread completed")
        }
    }
    let test = ThreadTest()
    test.createThread()
    
    
    let serialQueue = DispatchQueue(label: "serialQueue")
    print("1st statement")
    serialQueue.async {
        for i in 0...5{
            print("serial queue async statement \(i) ")
        }
    }
    print("2nd statement")
    serialQueue.sync {
        for i in 0...5{
            print("serial queue sync statement \(i) ")
        }
    }
    print("end of the serial queue")
    print("------------")
    
    //concurrent queue
    let concurrentQueue = DispatchQueue(label: "concurrentQueue", attributes: .concurrent)
    print("1st statement of concurrent queue")
    concurrentQueue.async {
        for i in 0...5{
            print("concurrent queue async statement \(i) ")
        }
    }
    print("2nd statement of concurrent queue")
    concurrentQueue.sync {
        for i in 0...5{
            print("concurrent queue sync statement \(i) ")
        }
    }
    print("concurrent queue completed")
}
