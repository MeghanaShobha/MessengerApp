import SwiftUI

struct Product: Identifiable {
    let id = UUID()
    let name: String
    let price: Double
    let icon: String
}
struct ContentView: View {
    let products = [
        Product(name: "iPhone", price: 799, icon: "iphone"),
        Product(name: "MacBook", price: 1299, icon: "laptopcomputer"),
        Product(name: "Apple Watch", price: 399, icon: "applewatch"),
        Product(name: "AirPods", price: 249, icon: "airpods")
    ]
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Products")
                    .font(.largeTitle)
                    .bold()
                    .padding(.horizontal)
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        ForEach(products) { product in
                            VStack(spacing: 20) {
                                Image(systemName: product.icon)
                                    .font(.system(size: 70))
                                Text(product.name)
                                    .font(.title2)
                                    .bold()
                                Text("$\(product.price, specifier: "%.2f")")
                                    .font(.title3)
                            }
                            .frame(maxHeight: .infinity)
                            .containerRelativeFrame(.horizontal) { width, axis in
                                width * 0.7
                            }
                            .background(.blue.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                        }
                    }
                    .scrollTargetLayout()
                }
                .scrollTargetBehavior(.viewAligned)
                .frame(height: 300)
            }
            .navigationTitle("Store")
        }
    }
}

#Preview {
    ContentView()
}
