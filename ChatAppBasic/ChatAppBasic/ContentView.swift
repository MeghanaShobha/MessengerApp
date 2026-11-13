//
//  ContentView.swift
//  ChatAppBasic
//
//  Created by Meghana IOS on 11/11/26.
//
import SwiftUI

struct ContentView: View {

    @ObservedObject var Services: ChatSocketService
    @State private var HomePage = false

    var body: some View {
        Group {
            if HomePage {
                LoginView(Services: Services) {
                    print("logout is done")
                    HomePage = false
                }
            } else {
                SplashView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                            withAnimation {
                                HomePage = true
                            }
                        }
                    }
            }
        }
    }
}

#Preview {
    ContentView(Services: ChatSocketService())
}
