//
//  LoginView.swift
//  MessengerApp
//
//  Created by Meghana IOS on 03/11/26.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        Image(systemName: "person.circle.fill")
            .resizable()
            .frame(width: 100, height: 100)
            .foregroundStyle(.blue)
        Text("Email")
        Text("Password")
    }
}

#Preview {
    LoginView()
}
