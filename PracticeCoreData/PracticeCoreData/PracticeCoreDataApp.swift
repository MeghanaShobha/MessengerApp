//
//  PracticeCoreDataApp.swift
//  PracticeCoreData
//
//  Created by Meghana IOS on 05/10/26.
//

import SwiftUI
import CoreData

@main
struct PracticeCoreDataApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
