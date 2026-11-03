//
//  ContentView.swift
//  Observable
//
//  Created by Meghana IOS on 28/09/26.
//

import SwiftUI
import Observation


@Observable
class User: Codable {
    enum CodingKeys:String, CodingKey {
        case _name = "name"
    }
    var name = "Meghana"
}
struct ContentView: View {
    var body: some View {
        Button("Encode Meghana"){
            let user = User()
            let data = try! JSONEncoder().encode(user)
            let str = String(decoding:data,as : UTF8.self)
            print(str)
        }
    }
}

#Preview {
    ContentView()
}
