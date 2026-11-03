//
//  ContentView.swift
//  challenge1
//
//  Created by Meghana IOS on 01/09/26.
//

import SwiftUI

struct ContentView: View {
    @State private var inputUnit = "Meters"
    @State private var outputUnit = "Feet"
    @State private var value = 10.0
    let units = [
        "Meters",
        "Kilometers",
        "Feet",
        "Yards",
        "Miles"
    ]
    var convertedValue: Double {
        let valueInMeters: Double
        switch inputUnit {
        case "Meters":
            valueInMeters = value
        case "Kilometers":
            valueInMeters = value * 1000
        case "Feet":
            valueInMeters = value * 0.3048
        case "Yards":
            valueInMeters = value * 0.9144
        case "Miles":
            valueInMeters = value * 1609.344
        default:
            valueInMeters = value
        }
        
        switch outputUnit {
        case "Meters":
            return valueInMeters
        case "Kilometers":
            return valueInMeters / 1000
        case "Feet":
            return valueInMeters / 0.3048
        case "Yards":
            return valueInMeters / 0.9144
        case "Miles":
            return valueInMeters / 1609.344
        default:
            return valueInMeters
        }
    }
    
    var body: some View {
    
        NavigationStack {
            Form {
                Section("Input Unit") {
                    Picker("From", selection: $inputUnit) {
                        ForEach(units, id: \.self) { unit in
                            Text(unit)
                        }
                    }
                }
                Section("Output Unit") {
                    Picker("To", selection: $outputUnit) {
                        ForEach(units, id: \.self) { unit in
                            Text(unit)
                        }
                    }
                }
                Section("Value") {
                    TextField(
                        "Enter value",
                        value: $value,
                        format: .number
                    )
                    .keyboardType(.decimalPad)
                }
                Section("Result") {
                    Text("\(convertedValue, specifier: "%.2f") \(outputUnit)")
                        .font(.title2)
                        .fontWeight(.bold)
                }
            }
            .navigationTitle("Length Converter")
        }
    }
}
#Preview {
    ContentView()
}
