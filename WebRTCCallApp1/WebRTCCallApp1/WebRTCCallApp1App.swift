//
//  WebRTCCallApp1App.swift
//  WebRTCCallApp1
//
//  Created by Meghana IOS on 26/10/26.
//
import SwiftUI
import FirebaseCore
import FirebaseAuth

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions:
            [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        FirebaseApp.configure()

        Auth.auth().signInAnonymously { _, error in
            if let error {
                print("Firebase sign-in error:", error.localizedDescription)
            }
        }

        return true
    }
}

@main
struct WebRTCCallAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self)
    var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
