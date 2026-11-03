//
//  AddressView.swift
//  Cupcake2
//
//  Created by Meghana IOS on 30/09/26.
//
import SwiftUI

struct AddAddressView: View {
    @Bindable var order: Order
    @Binding var path: NavigationPath
    var body: some View {
        Form {
            Section(header: Text("Address")) {
                TextField("Name", text: $order.name)
                TextField("Address", text: $order.setAddress)
                TextField("City", text: $order.city)
                TextField("Pin", text: $order.pin)
                TextField("State",text:$order.State)
                TextField("Country",text:$order.Country)
                TextField("ContactNumber",text:$order.ContactNumber)
            }
            Section {
                NavigationLink("Check out", value: "checkout")
            }
            .disabled(order.ValidAddress == false)
        }
        .navigationTitle("Add Address")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AddAddressView(order: Order(),path: .constant(NavigationPath()))
}
