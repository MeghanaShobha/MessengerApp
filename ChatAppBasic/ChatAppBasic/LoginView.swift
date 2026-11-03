//
//  LoginView.swift
//  ChatAppBasic
//
//  Created by Meghana IOS on 03/11/26.
//
import SwiftUI

struct LoginView: View {

    @State private var email = ""
    @State private var password = ""
    @State private var showHome = false
    @State private var errorMessage = ""

    let correctEmail = "Meghana@gmail.com"
    let correctPassword = "123456"

    var body: some View {

        NavigationStack {

            VStack(spacing: 25) {

                Spacer()

                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundStyle(.blue)

                Text("Login")
                    .font(.largeTitle)
                    .bold()

                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .padding()
                    .background(.gray.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                SecureField("Password", text: $password)
                    .padding()
                    .background(.gray.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                Button("Login") {
                    loginUser()
                }
                .font(.headline)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(.blue)
                .clipShape(RoundedRectangle(cornerRadius: 10))

                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundStyle(.red)
                }

                Spacer()
            }
            .padding(30)
            .navigationDestination(isPresented: $showHome) {
                ContentView()
            }
        }
    }

    func loginUser() {

        if email == correctEmail && password == correctPassword {

            showHome = true
            errorMessage = ""

        } else {

            errorMessage = "Invalid email or password"
        }
    }
}

#Preview {
    LoginView()
}

