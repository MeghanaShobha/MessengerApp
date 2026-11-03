//
//  operationsCRUDpractice11App.swift
//  operationsCRUDpractice11
//
//  Created by Meghana IOS on 06/10/26.
//

import SwiftUI
import CoreData

@main
struct operationsCRUDpractice11App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
