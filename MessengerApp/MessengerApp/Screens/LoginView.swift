//
//  LoginView.swift
//  MessengerApp
//
//  Created by Meghana IOS on 03/11/26.
//

import SwiftUI

struct LoginView: View {
    @State private var peerName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    @State private var showHome = false
    @StateObject private var chatService = ChatSocketService()
    var isShowLogin :() -> Void
    
    let correctEmail = ""
    let correctPassword = ""

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
                HomeView(chatService: chatService,isShowLogin: {
                    isShowLogin()
                },
                peerName: peerName
            )
            }
        }
    }
    func loginUser() {
        let userEmail = email.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        
        let userPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !userEmail.isEmpty && !password.isEmpty else {
            errorMessage = "Please enter email and password"
            return
        }
        if userEmail == ""{
            peerName = ""
        }else{
            peerName = ""
        }
        
        errorMessage = ""
        chatService.connect(userId: userEmail)
        showHome = true
    }
}

#Preview {
    LoginView() { 
        
    }
}
