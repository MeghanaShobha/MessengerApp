//
//  TripMigrationPlan.swift
//  SwiftDataTrips
//
//  Created by Meghana IOS on 13/10/26.
//

import SwiftData

enum TripMigrationPlan: SchemaMigrationPlan {
    static var schemas: [any VersionedSchema.Type] {
        [
            TripSchemaV1.self,
            TripSchemaV2.self
        ]
    }
    static var stages: [MigrationStage] {
        [
            MigrationStage.lightweight(
                fromVersion: TripSchemaV1.self,
                toVersion: TripSchemaV2.self
            )
        ]
    }
}
