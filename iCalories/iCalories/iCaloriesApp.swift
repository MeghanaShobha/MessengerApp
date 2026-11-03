//
//  iCaloriesApp.swift
//  iCalories
//
//  Created by Meghana IOS on 07/10/26.
//
import SwiftUI
internal import CoreData

@main
struct iCaloriesApp: App {
    @StateObject private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(dataController)
        }
    }
}
