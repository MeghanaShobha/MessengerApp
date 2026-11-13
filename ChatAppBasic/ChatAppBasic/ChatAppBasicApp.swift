//
//  ChatAppBasicApp.swift
//  ChatAppBasic
//
//  Created by Meghana IOS on 11/11/26.
//

import SwiftUI

@main
struct ChatAppBasicApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(Services: ChatSocketService())
        }
    }
}
