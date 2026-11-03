//
//  SwiftdataExampleApp.swift
//  SwiftdataExample
//
//  Created by Meghana IOS on 09/10/26.
//

import SwiftUI
import SwiftData

@main
struct SwiftdataExampleApp: App {
//    let container:ModelContainer = {
//        let schema = Schema([Expense.self])
//        let container = try! ModelContainer(for :schema ,configurations:[])
//        return container
//    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
//        .modelContainer(container)
        .modelContainer(for :[Expense.self])
//        .modelContainer(for :Expense.self,inMemory: true)
    }
}

