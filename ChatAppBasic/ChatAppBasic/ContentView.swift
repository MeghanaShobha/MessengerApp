//
//  ContentView.swift
//  ChatAppBasic
//
//  Created by Meghana IOS on 03/11/26.
//
import SwiftUI

struct ContentView: View {

    var body: some View {
        home()
    }

    func home() -> some View {
        TabView {

            VStack {
                AsyncImage(url: URL(string: "https://images.unsplash.com/reserve/bOvf94dPRxWu0u3QsPjF_tree.jpg?ixid=NHwxMjA3fDA&ixlib=rb-4.1.0")) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(maxWidth: .infinity)
                .clipped()
                .ignoresSafeArea(edges: .all)
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }

            MessengerView()
                .tabItem {
                    Image(systemName: "message.fill")
                    Text("Messenger")
                }

            Text("Audio Call Screen")
                .tabItem {
                    Image(systemName: "phone.fill")
                    Text("Audio")
                }

            Text("Video Call Screen")
                .tabItem {
                    Image(systemName: "video.fill")
                    Text("Video")
                }
        }
    }
}

#Preview {
    ContentView()
}
