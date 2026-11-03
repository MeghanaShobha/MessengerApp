import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @Query(
        sort: \TripSchemaV2.Trip.startDate,
        order: .forward
    )
    private var trips: [TripSchemaV2.Trip]
    @State private var showTripSheet = false
    @State private var selectedTripType = "Personal"
    var body: some View {
        NavigationStack {
            List {
                Section("All Trips") {
                    ForEach(trips) { trip in
                        VStack(alignment: .leading, spacing: 5) {
                            Text(trip.name)
                                .font(.headline)
                            Label(
                                trip.destination,
                                systemImage: "mappin.and.ellipse"
                            )
                            .foregroundStyle(.secondary)
                            Text(trip.startDate, style: .date)
                                .font(.caption)

                            if let personal = trip as? TripSchemaV2.PersonalTrip {
                                Label(
                                    "Personal: \(personal.notes)",
                                    systemImage: "person"
                                )
                            }
                            if let business = trip as? TripSchemaV2.BusinessTrip {
                                Label(
                                    "Company: \(business.company)",
                                    systemImage: "briefcase"
                                )
                            }
                        }
                        .padding(.vertical, 4)
                    }
                    .onDelete(perform: deleteTrips)
                }
                Section("Add Trips") {
                    Button {
                        selectedTripType = "Personal"
                        showTripSheet = true
                    } label: {
                        Label("Add Personal Trip", systemImage: "person")
                    }
                    Button {
                        selectedTripType = "Business"
                        showTripSheet = true
                    } label: {
                        Label("Add Business Trip", systemImage: "briefcase")
                    }
                }
            }
            .navigationTitle("My Trips")
            .sheet(isPresented: $showTripSheet) {
                AddTripSheet(tripType: selectedTripType)
            }
        }
    }
    private func deleteTrips(at offsets: IndexSet) {
        for index in offsets {
            context.delete(trips[index])
        }
        save()
    }
    private func save() {
        do {
            try context.save()
        } catch {
            print("Save failed: \(error.localizedDescription)")
        }
    }
}

struct AddTripSheet: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    let tripType: String
    @State private var name = ""
    @State private var destination = ""
    @State private var startDate = Date.now
    @State private var endDate = Calendar.current.date(
        byAdding: .day,
        value: 1,
        to: .now
    ) ?? .now
    @State private var notes = ""
    @State private var company = ""
    @State private var errorMessage = ""

    var body: some View {
        NavigationStack {
            Form {
                Section("Trip Details") {
                    Text("Trip Type: \(tripType)")
                        .font(.headline)
                    TextField("Trip Name", text: $name)
                    TextField(
                        "Enter destination",
                        text: $destination
                    )
                    DatePicker(
                        "Start Date",
                        selection: $startDate,
                        displayedComponents: .date
                    )
                    DatePicker(
                        "End Date",
                        selection: $endDate,
                        in: startDate...,
                        displayedComponents: .date
                    )
                }
                if tripType == "Personal" {
                    Section("Personal Details") {
                        TextField(
                            "Notes or places to visit",
                            text: $notes,
                            axis: .vertical
                        )
                    }
                } else {
                    Section("Business Details") {
                        TextField(
                            "Company Name",
                            text: $company
                        )
                    }
                }
                if !errorMessage.isEmpty {
                    Section {
                        Text(errorMessage)
                            .foregroundStyle(.red)
                    }
                }
            }
            .navigationTitle("New \(tripType) Trip")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        addTrip()
                    }
                    .disabled(
                        name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                        destination.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                    )
                }
            }
        }
    }
    private func addTrip() {
        let tripName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let place = destination.trimmingCharacters(in: .whitespacesAndNewlines)
        if tripType == "Personal" {
            let trip = TripSchemaV2.PersonalTrip(
                name: tripName,
                destination: place,
                startDate: startDate,
                endDate: endDate,
                notes: notes
            )
            context.insert(trip)
        } else {
            let trip = TripSchemaV2.BusinessTrip(
                name: tripName,
                destination: place,
                startDate: startDate,
                endDate: endDate,
                company: company
            )
            context.insert(trip)
        }
        do {
            try context.save()
            dismiss()
        } catch {
            errorMessage = "Could not save trip: \(error.localizedDescription)"
        }
    }
}
#Preview {
    ContentView()
        .modelContainer(
            for: [
                TripSchemaV2.Trip.self,
                TripSchemaV2.PersonalTrip.self,
                TripSchemaV2.BusinessTrip.self
            ],
            inMemory: true
        )
}
