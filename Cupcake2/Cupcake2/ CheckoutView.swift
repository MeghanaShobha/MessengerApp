//
//  CheckoutView.swift
//  Cupcake2
//
//  Created by Meghana IOS on 30/09/26.
//

import SwiftUI
struct CheckoutView: View {
    var order: Order
    @State private var orderplace = false
    @Binding var path :NavigationPath
    let types = ["Vanilla", "Chocolate", "Red Velvet", "Blueberry"]
    var body: some View {
        ScrollView{
            VStack{
                AsyncImage(url: URL(string: "https://as1.ftcdn.net/v2/jpg/03/07/44/50/1000_F_307445020_MGgZzMwRdgDLtjDPEAcKAcOfu9pibUdn.jpg")
                           ,scale:3){
                    image in
                    image
                        .resizable()
                        .scaledToFill()
                }placeholder: {
                    ProgressView()
                }
                .frame(height: 250)
                .frame(maxWidth:.infinity)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.horizontal)
                .padding(.top)
                
                Text("Your order")
                    .font(.title)
                    .bold()
                    .background(.ultraThinMaterial)
                    .padding(.horizontal)
                
                Section{
                    Text("Your Cake type is: \(types[order.type])")
                    Text("Number of Cakes you ordered: \(order.quantity)")
//                    Text("SpecialRequestEnable is ON or OFF: \(order.specialRequestEnable ? "ON" : "OFF")")
                    if order.specialRequestEnable {
                        Text("Special Request: ON")
                        if order.addSprinkles {
                            Text("Sprinkles: ON")
                        }
                        if order.extraFrosting {
                            Text("Extra Frosting: ON")
                        }
                    } else {
                        Text("Special Request: OFF")
                    }
                }
                .padding(.horizontal)
                
                Text("Your total is\(order.cost,format: .currency(code: "INR"))")
                    .font(.title)
                    .bold( )
                    .padding()
                
                Text("Displaying Your Address")
                    .font(.title)
                    .bold()
                    .background(.ultraThinMaterial)
                    .padding(.horizontal)
                Section{
                    Text("Name: \(order.name)")
                    Text("Address: \(order.setAddress)")
                    Text("City: \(order.city)")
                    Text("Pin: \(order.pin)")
                    Text("State: \(order.State)")
                    Text("Country: \(order.Country )")
                    Text("Contact Number: \(order.ContactNumber )")
                    
                }
                Button("Place order"){
                    orderplace = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        path = NavigationPath()
                    }
                }
                .navigationTitle("Checkout")
                .navigationBarTitleDisplayMode(.inline)
                .sheet(isPresented: $orderplace) {
                    VStack(spacing: 20) {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 60))
                        .foregroundStyle(.green)
                        Text("Your order has been placed")
                    }
                 .presentationDetents([.height(570)])
                }
                
            }
        }
        .navigationTitle("Checkout")
        .navigationBarTitleDisplayMode(.inline)
    }
}
#Preview {
    CheckoutView(order: Order(), path: .constant(NavigationPath()))
}
