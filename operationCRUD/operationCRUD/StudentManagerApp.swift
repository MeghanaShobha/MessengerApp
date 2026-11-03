//
//  StudentManagerApp.swift
//  operationCRUD
//
//  Created by Meghana IOS on 05/10/26.
//

import SwiftUI
import CoreData

@main
struct StudentManagerApp: App {
    let persistenceController = PersistenceController1.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
