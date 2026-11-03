//
//  PersistenceController.swift
//  operationCRUD
//
//  Created by Meghana IOS on 05/10/26.
//

import CoreData

struct PersistenceController1 {
    static let shared = PersistenceController1()

    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "StudentModel")

        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Core Data error: \(error), \(error.userInfo)")
            }
        }
    }
}
