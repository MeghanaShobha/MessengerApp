//
//  operationsCRUDpracticeApp.swift
//  operationsCRUDpractice
//
//  Created by Meghana IOS on 06/10/26.
//

import SwiftUI
import CoreData

@main
struct operationsCRUDpracticeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
