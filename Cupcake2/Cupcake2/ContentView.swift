//
//  ContentView.swift
//  Cupcake2
//
//  Created by Meghana IOS on 30/09/26.
//
import SwiftUI

struct ContentView: View {
    @State private var order = Order()
    @State private var path = NavigationPath()
    @State private var showAlert = false
    var body: some View {
        NavigationStack(path: $path) {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.type) {
                        ForEach(Order.types.indices, id: \.self) {
                            Text(Order.types[$0])
                        }
                    }
                    Stepper(
                        "You want any extra items for cake: \(order.quantity)",
                        value: $order.quantity,
                        in: 1...20
                    )
                }
                Section {
                    Toggle(
                        "You want any extra items for cake?",
                        isOn: $order.specialRequestEnable
                    )
                    if order.specialRequestEnable {
                        Toggle(
                            "You want add sprinkles on your cake",
                            isOn: $order.addSprinkles
                        )
                        Toggle(
                            "You want add extra frosting",
                            isOn: $order.extraFrosting
                        )
                    }
                }
                Button("Next") {
                    if !order.specialRequestEnable ||
                        order.addSprinkles ||
                        order.extraFrosting {
                        path.append("address")
                    } else {
                        showAlert = true
                    }
                }
            }
            .navigationTitle("CUPCAKE SHOP")
            .navigationDestination(for: String.self) { value in
                if value == "address" {
                    AddAddressView(order: order, path: $path)
                }
                if value == "checkout" {
                    CheckoutView(order: order, path: $path)
                }
            }
        }
        .alert("Extra Request", isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Please select the extra request.")
        }
    }
}

#Preview {
    ContentView()
}
