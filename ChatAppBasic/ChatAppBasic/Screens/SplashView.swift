//
//  SplashView.swift
//  ChatAppBasic
//
//  Created by Meghana IOS on 11/11/26.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack{
            VStack{
                AsyncImage(url: URL(string: "https://img.magnific.com/free-photo/courage-man-jump-through-gap-hill-business-concept-idea_1323-262.jpg?semt=ais_hybrid&w=740&q=80"))
                    .frame(width: 200, height: 200)
                    .clipShape(Capsule())
                Text("App is Loading...")
                
            }
        }
    }
}

#Preview {
    SplashView()
}
