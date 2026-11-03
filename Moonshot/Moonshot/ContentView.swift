//
//  ContentView.swift
//  Moonshot
//
//  Created by Meghana IOS on 17/09/26.
//

//import SwiftUI
//
//struct ContentView: View {
//    var body: some View {
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
//            Text("Hello, world!")
//        }
//        .padding()
//    }
//}
//
//#Preview {
//    ContentView()
//}


import SwiftUI
struct Astronaut: Codable, Identifiable {
    let id: String
    let name: String
    let description: String
}
struct ContentView: View {
    let astronauts: [Astronaut] = [
        Astronaut(id: "grissom", name: "Virgil I. Grissom", description: "American astronaut and test pilot."),
        Astronaut(id: "white", name: "Edward H. White", description: "American astronaut and engineer."),
        Astronaut(id: "chaffee", name: "Roger B. Chaffee", description: "American astronaut and naval aviator.")
    ]
    var body: some View {
        NavigationStack {
            List(astronauts) { astronaut in
                NavigationLink(astronaut.name) {
                    VStack(alignment: .leading, spacing: 20) {
                        Text(astronaut.name)
                            .font(.title)
                            .bold()
                        Text(astronaut.description)
                            .font(.body)
                    }
                    .padding()
                    .navigationTitle("Astronaut")
                }
            }
            .navigationTitle("Astronauts")
        }
    }
}
#Preview {
    ContentView()
}

