//
//  ContentView.swift
//  fourthproject
//
//  Created by Meghana IOS on 04/09/26.
//

import SwiftUI

struct ContentView: View {
    @State private var wokeup = Date.now
    var body: some View {
        VStack {
            Text("When do you want to wokeup ?")
                .font(.title2)
            DatePicker("woke up time", selection: $wokeup, displayedComponents: .hourAndMinute
            )
            .padding()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
