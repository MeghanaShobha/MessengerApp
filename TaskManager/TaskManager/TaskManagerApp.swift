//
//  TaskManagerApp.swift
//  TaskManager
//
//  Created by Meghana IOS on 06/10/26.
//

import SwiftUI
import CoreData

@main
struct TaskManagerApp: App {
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .commands{
            CommandMenu("Task"){
                Button("Add new task"){
                    
                }
                .keyboardShortcut(KeyEquivalent("r"),modifiers: .command)
            }
            CommandGroup(after: .newItem){
                Button("Add new Group"){
                    
                }
            }
        }
        # if os(macOS)
        WindowGroup("Special window"){
            Text("special window")
        }
    }
}
