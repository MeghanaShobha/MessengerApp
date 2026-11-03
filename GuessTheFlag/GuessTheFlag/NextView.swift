//
//  NextView.swift
//  GuessTheFlag
//
//  Created by Meghana IOS on 02/09/26.
//

import SwiftUI

struct NextView: View {
    @State private var showingAlert = false
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.cyan, .white],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            VStack(spacing: 40) {
                NavigationLink {
                    ThirdView()
                } label: {
                    Image(systemName: "heart.fill")
                        .font(.system(size: 70))
                        .foregroundStyle(.black)
                }
                Button {
                    showingAlert = true
                } label: {
                    Label("Edit", systemImage: "pencil")
                        .padding()
                        .foregroundStyle(.white)
                        .background(.blue)
                }
            }
        }
        .navigationTitle("Next Page")
        .alert("Edit", isPresented: $showingAlert) {
            Button("OK") {
                showingAlert = false
            }
        } message: {
            Text("This is edit")
        }
        
    }
}

#Preview {
    NextView()
}
