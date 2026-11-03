//
//  Persistence.swift
//  StudentManager
//
//  Created by Meghana IOS on 07/10/26.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    static let preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        let student = Student(context: viewContext)
        student.name = "Meghana"
        student.age = 25
        student.course = "iOS"
        
        try? viewContext.save()
        
        return result
    }()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "StudentManager")
        
        if inMemory {
            container.persistentStoreDescriptions.first!.url =
                URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error)")
            }
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
