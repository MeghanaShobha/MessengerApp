//
//  HomeView.swift
//  ChatAppBasic
//
//  Created by Meghana IOS on 11/11/26.
//
//
import SwiftUI

struct HomeView: View {
    var isShowLogin: () -> Void
    @ObservedObject var Services : ChatSocketService
    @State private var selectedTab = 0
    let peerName:String
    var body: some View {
        ZStack{
            TabView(selection: $selectedTab){
                AsyncImage(url:URL(string:"https://i0.wp.com/picjumbo.com/wp-content/uploads/sunset-wallpaper-free-image.jpeg?h=800&quality=80")) { image in
                    image
                        .resizable()
                        .scaledToFill()
                }placeholder: {
                    ProgressView()
                }
                .ignoresSafeArea(edges: .all)
                .tabItem {
                        Label("Home", systemImage: "house")
                    }
                .tag(0)
                ChatView(Services: Services, peerName: peerName)
                    .tabItem {
                        Label("Chat", systemImage: "bubble.right")
                    }
                    .tag(1)
                Text("Audio")
                    .tabItem {
                        Label("Audio", systemImage: "mic")
                    }
                    .tag(2)
                Text("Video")
                    .tabItem {
                        Label("Video", systemImage: "video")
                    }
                    .tag(3)
            }
        }
        .overlay(alignment: .topTrailing){
            Button{
                Services.disconnect()
                isShowLogin()
            }label:{
                Label("Logout",systemImage: "rectangle.portrait.and.arrow.right")
                    .padding(10)
                    
                
            }
        }
        .foregroundStyle(.black)
    }
}





#Preview {
    HomeView(
        isShowLogin: {}, Services : ChatSocketService(),
        peerName: ""
    )
}
