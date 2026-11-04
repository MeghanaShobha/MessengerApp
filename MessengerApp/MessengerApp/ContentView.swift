//
//  ContentView.swift
//  MessengerApp
//
//  Created by Meghana IOS on 03/11/26.
//

import SwiftUI

struct ContentView: View {
    @State private var showHome = false
    var body: some View {
        Group{
            if showHome {
                LoginView(){
                    print("logout is done")
                    showHome  = false
                }
            }else{
                SplashView()
                    .onAppear(){
                        withAnimation {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                                showHome = true
                            }
                        }
                      
                    }
            }
        }
       
    }
}

#Preview {
    ContentView()
}
