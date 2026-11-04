//
//  SplashView.swift
//  MessengerApp
//
//  Created by Meghana IOS on 03/11/26.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
       ZStack {
            Color.pink
               .ignoresSafeArea(edges: .all)
           VStack(spacing:15){
               AsyncImage(url: URL(string: "https://img.magnific.com/free-photo/closeup-shot-beautiful-butterfly-orange-petaled-flower_181624-13884.jpg?semt=ais_hybrid&w=740&q=80"))
                   .frame(width: 250, height: 250)
                   .clipShape(Circle())
                   .overlay(Circle().stroke(Color.white, lineWidth: 4))
               Text("App is Loading..!")
                   .font(.largeTitle)
           }
       }
    }
}

#Preview {
    SplashView()
}
