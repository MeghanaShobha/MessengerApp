//
//  TripModels.swift
//  SwiftDataTrips
//
//  Created by Meghana IOS on 13/10/26.
//
import Foundation
import SwiftData

enum TripSchemaV1: VersionedSchema {
    static var versionIdentifier: Schema.Version {
        Schema.Version(1, 0, 0)
    }
    static var models: [any PersistentModel.Type] {
        [Trip.self]
    }
    @Model
    final class Trip {
        var name: String
        var destination: String
        var startDate: Date
        var endDate: Date
        init(
            name: String,
            destination: String,
            startDate: Date,
            endDate: Date
        ) {
            self.name = name
            self.destination = destination
            self.startDate = startDate
            self.endDate = endDate
        }
    }
}

@available(iOS 26.0, *)
enum TripSchemaV2: VersionedSchema {
    static var versionIdentifier: Schema.Version {
        Schema.Version(2, 0, 0)
    }
    static var models: [any PersistentModel.Type] {
        [
            Trip.self,
            PersonalTrip.self,
            BusinessTrip.self
        ]
    }
    @available(iOS 26.0, *)
    @Model
    class Trip {
        var name: String
        var destination: String
        var startDate: Date
        var endDate: Date

        init(
            name: String,
            destination: String,
            startDate: Date,
            endDate: Date
        ) {
            self.name = name
            self.destination = destination
            self.startDate = startDate
            self.endDate = endDate
        }
    }
    @available(iOS 26.0, *)
    @Model
    final class PersonalTrip: Trip {
        var notes: String

        init(
            name: String,
            destination: String,
            startDate: Date,
            endDate: Date,
            notes: String = ""
        ) {
            self.notes = notes
            super.init(
                name: name,
                destination: destination,
                startDate: startDate,
                endDate: endDate
            )
        }
    }
    @available(iOS 26.0, *)
    @Model
    final class BusinessTrip: Trip {
        var company: String

        init(
            name: String,
            destination: String,
            startDate: Date,
            endDate: Date,
            company: String = ""
        ) {
            self.company = company
            super.init(
                name: name,
                destination: destination,
                startDate: startDate,
                endDate: endDate
            )
        }
    }
}
