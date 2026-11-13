//
//  LoginView.swift
//  ChatAppBasic
//
//  Created by Meghana IOS on 11/11/26.
//
import SwiftUI

struct LoginView: View {
    @StateObject var Services : ChatSocketService
    @State private var email:String = ""
    @State private var password:String = ""
    @State private var errorMessage = ""
    @State private var HomePage = false
    @State private var peerName = ""
    var isShowLogin :() -> Void
    
    let correctEmail = ""
    let correctPassword = ""
    
    var body: some View {
        NavigationStack {
            VStack{
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width:100,height:100)
                Text("Login")
                    .padding(10)
                TextField("Email",text: $email)
                    .keyboardType(.emailAddress)
                    .padding(10)
                    .frame(width: 250)
                    .background(.gray.opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                SecureField("Password", text: $password)
                    .padding(10)
                    .frame(width: 250)
                    .background(.gray.opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                Button("login"){
                    userLogin()
                }
                .font(.headline)
                .padding(10)
                .frame(width: 250)
                .background(.black)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundStyle(Color.red)
                }
            }
            .navigationDestination(isPresented: $HomePage) {
                HomeView(
                    isShowLogin: {
                        HomePage = false
                    }, Services:Services,
                    peerName: peerName
                )
            }
            
        }
    }
        
    func userLogin() {
        let userEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let userPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !userEmail.isEmpty, !userPassword.isEmpty else {
            errorMessage = "Please enter the details"
            return
        }

        peerName = userEmail
        errorMessage = ""

        Services.connect(userId: userEmail)
        HomePage = true
    }
    
}




#Preview {
    LoginView(Services:ChatSocketService()){}
}

