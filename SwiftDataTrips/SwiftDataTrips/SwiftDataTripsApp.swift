//
//  SwiftDataTripsApp.swift
//  SwiftDataTrips
//
//  Created by Meghana IOS on 13/10/26.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataTripsApp: App {
    let container: ModelContainer = {
        let schema = Schema(
            versionedSchema: TripSchemaV2.self
        )
        do {
            return try ModelContainer(
                for: schema,
                migrationPlan: TripMigrationPlan.self
            )
        } catch {
            print("Failed to create ModelContainer: \(error)")

            return try! ModelContainer(
                for: Schema(versionedSchema: TripSchemaV2.self)
            )
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(container)
    }
}
