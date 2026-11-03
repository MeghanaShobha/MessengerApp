import SwiftUI

struct ContentView: View {
   
    var body: some View {
        NavigationStack {
            ZStack {
                RadialGradient(
                    colors: [.white, .red],
                    center: .center,
                    startRadius: 1,
                    endRadius: 250
                    
                )
                .ignoresSafeArea()

                
                VStack {
                    Text("Welcome to my Page")
                        .font(.largeTitle)
                    
                    NavigationLink("Move next") {
                        NextView()
                    }
                    .buttonStyle(.bordered)
                    .tint(.black)
                }
            }
        }
    }
}


#Preview {
    ContentView()
}
