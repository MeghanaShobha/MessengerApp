//
//  HomeView.swift
//  MessengerApp
//
//  Created by Meghana IOS on 03/11/26.
//

import SwiftUI
import Combine

struct HomeView: View {
    @ObservedObject var chatService: ChatSocketService
    var isShowLogin: () -> Void
    var body: some View {
        ZStack{
            TabView{
                AsyncImage(url: URL(string: "https://img.magnific.com/free-photo/closeup-scarlet-macaw-from-side-view-scarlet-macaw-closeup-head_488145-3540.jpg?semt=ais_hybrid&w=740&q=80")) { image in
                        image
                            .resizable()
                            .scaledToFill()
                        } placeholder: {
                            ProgressView()
                        }
                        .ignoresSafeArea(edges: .all)
                        .tabItem{
                            Label("Home", systemImage: "house")
                        }
                
                ChatView(chatService: ChatSocketService())
                    .tabItem{
                        Label("Chat", systemImage: "bubble.right")
                    }
                Text("Audio")
                    .tabItem{
                        Label("Audio", systemImage: "mic")
                    }
                Text("Video")
                    .tabItem{
                        Label("Video", systemImage: "video")
                    }
            }
        }
        .ignoresSafeArea(edges: .all)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .topLeading){
            Button{
                chatService.disconnect()
                isShowLogin()
            }label:{
                Label("Logout", systemImage: "rectangle.portrait.and.arrow.right")
                    .foregroundColor(.black)
                    .cornerRadius(10)
                    .padding(10)
                    .frame(maxWidth: .infinity,alignment: .trailing)
            }
        }
    }
}

#Preview {
    HomeView(
        chatService: ChatSocketService(),
        isShowLogin: {}
    )
}
