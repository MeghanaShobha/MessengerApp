import SwiftUI

struct CheckoutView: View {
//    @Environment(\.dismiss) var dismiss
    var order: Order
    @State private var orderPlaced = false
    @Binding var path: NavigationPath

    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(
                    url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"),
                    scale: 3
                ) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)

                Text("Your total is \(order.cost, format: .currency(code: "INR"))")
                    .font(.title)

                Button("Place Order") {
                    orderPlaced = true

                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        path = NavigationPath()
                    }
                   
                }
                .padding()

                if orderPlaced {
                    Text("Order Placed!")
                        .font(.title)
                        .padding()
                }
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

#Preview {
    CheckoutView(order: Order(), path: .constant(NavigationPath()))
}
