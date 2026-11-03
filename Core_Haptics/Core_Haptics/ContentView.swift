//
//  ContentView.swift
//  Core_Haptics
//
//  Created by Meghana IOS on 28/09/26.
//

import SwiftUI
import CoreHaptics

struct ContentView: View {
    @State private var engine: CHHapticEngine?
    var body: some View {
        Button("Tap me",action: complexSuccess)
            .onAppear(perform: prepareHaptics)
    }
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {
            print("Haptics are not supported")
            return
        }
        do{
            engine = try CHHapticEngine()
            try engine?.start()
            print("Haptic engine started successfully")
        }catch{
            print("there was an error creating the engine: \(error.localizedDescription)")
        }
    }
    func complexSuccess() {
        print("Button tapped")
        var events = [CHHapticEvent]()
        let intensity = CHHapticEventParameter(
            parameterID: .hapticIntensity,
            value: 1
        )
        let sharpness = CHHapticEventParameter(
            parameterID: .hapticSharpness,
            value: 1
        )
        let event = CHHapticEvent(
            eventType: .hapticTransient,
            parameters: [intensity, sharpness],
            relativeTime: 0
        )
        events.append(event)
        print("Haptic event created")
        print("Intensity: 1")
        print("Sharpness: 1")
        do {
            let pattern = try CHHapticPattern(
                events: events,
                parameters: []
            )
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
            print("Haptic played successfully")
        } catch {
            print("Failed to play pattern: \(error.localizedDescription)")
        }
    }
}

#Preview {
    ContentView()
}
