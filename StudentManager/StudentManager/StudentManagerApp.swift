//
//  StudentManagerApp.swift
//  StudentManager
//
//  Created by Meghana IOS on 07/10/26.
//

import SwiftUI
import CoreData

@main
struct StudentManagerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
