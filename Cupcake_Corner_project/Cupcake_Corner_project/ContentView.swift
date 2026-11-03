import SwiftUI

struct ContentView: View {
    @State private var order = Order()
    @State private var path = NavigationPath()

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
                        "Number of cakes: \(order.quantity)",
                        value: $order.quantity,
                        in: 3...20
                    )
                }

                Section {
                    Toggle(
                        "Any special requests?",
                        isOn: $order.specialRequestEnabled
                    )

                    if order.specialRequestEnabled {
                        Toggle(
                            "Add extra frosting",
                            isOn: $order.extraFrosting
                        )

                        Toggle(
                            "Add extra sprinkles",
                            isOn: $order.addSprinkles
                        )
                    }
                }

                Section {
                    NavigationLink("Delivery details", value: "address")
                }
            }
            .navigationTitle("Cupcake Corner")
            .navigationDestination(for: String.self) { value in
                if value == "address" {
                    AddressView(order: order, path: $path)
                }

                if value == "checkout" {
                    CheckoutView(order: order, path: $path)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
