import SwiftUI

struct ContentView: View {
    @State private var selectedTab = "Home"
    var body: some View {
        TabView(selection: $selectedTab) {
            MenuView()
                .tabItem {
                    Image(systemName: "line.3.horizontal")
                    Text("Menu")
                }
                .tag("Menu")
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
                .tag("Settings")
            ZStack {
                AsyncImage(url: URL(string: "https://www.whoa.in/2023-Whoa/nature-images-nature-photos-nature-wallpapers-beautiful-nature-images-3d-wallpapers-mobile-wallpaper.png")) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                } placeholder: {
                    ProgressView()
                }
            }
            .tag("Home")
            .tabItem {
                Image(systemName: "house")
            
            }
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
                .tag("Search")
            ProfileView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Profile")
                }
                .tag("Profile")
        }
    }
}
struct ProfileView: View {
    var body: some View {
        VStack {
            Image(systemName: "person.crop.circle.fill")
                .font(.system(size: 100))

            Text("Meghana")
                .font(.title)
        }
    }
}
struct SearchView: View {
    @Environment(\.openURL) var openURL
    var body: some View {
        VStack {
            Button("Open Google") {
                openURL(URL(string: "https://www.google.com")!)
            }
        }
    }
}
struct SettingsView: View {
    var body: some View {
        NavigationStack {
            List {
                Text("About phone")
                Text("System apps Updater")
                Text("Security status")
                Text("SIM cards & mobile networks")
                Text("Wifi")
                Text("Bluetooth")
                Text("Portable hotspot")
                Text("Connection & Sharing")
                
            }
            .navigationTitle("SettingsView")
        }
    }
}
struct MenuView: View {
    var body: some View {
        NavigationStack {
            List {
                Text("All Apps Info")
                Text("System Updater")
                Text("Security status")
            }
            .navigationTitle("Menu")
        }
    }
}
#Preview {
    ContentView()
}
