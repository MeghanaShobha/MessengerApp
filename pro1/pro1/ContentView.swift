

import SwiftUI

struct ContentView: View {
    @State private var isDarkMode = false
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink {
                    ProfileView(isDarkMode: $isDarkMode)
                    
                } label: {
                    Text("Tap me for Profile Card")
                        .font(.title2.bold())
                        .padding(30)
                        .background(.red)
                        .foregroundStyle(.white)
                        .clipShape(.capsule)
                    
                }
            }
            .navigationTitle("My Profile")
            
        }
    }
        
}
struct ProfileView: View {
    @Binding var isDarkMode: Bool
    @State private var scale = 1.0
    @State private var rotation = 0.0
    @State private var dragAmount = CGSize.zero
    var body: some View {
        ZStack(alignment: .topLeading) {
            if isDarkMode {
                Color.black.ignoresSafeArea()
            } else {
                Color.white.ignoresSafeArea()
            }
            VStack {
                Toggle("Dark Mode", isOn: $isDarkMode)
                    .padding()
                    .foregroundStyle(isDarkMode ? .white : .black)
                Spacer()
                ZStack(alignment: .bottomTrailing) {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(.purple)
                        .frame(width: 280, height: 350)
                    VStack(spacing: 20) {
                        Image(systemName: "person.circle.fill")
                            .font(.system(size: 100))
                        Text("Meghana")
                            .font(.largeTitle.bold())
                        Text("SwiftUI Developer")
                            .font(.title3)
                    }
                    .foregroundStyle(.white)
                    .frame(width: 280, height: 350)

                }
                .scaleEffect(scale)
                .rotation3DEffect(
                    .degrees(rotation),
                    axis: (x: 0, y: 0, z:1 )
                )
                .offset(dragAmount)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            dragAmount = value.translation
                        }
                        .onEnded { _ in
                            withAnimation(.spring()) {
                                dragAmount = .zero
                            }
                        }
                )
                .animation(.easeInOut, value: isDarkMode)
                Spacer()
                HStack {
                    Button("Scale") {
                        withAnimation(.easeIn) {
                            scale = scale == 1 ? 1.4 : 1
                        }
                    }
                    Button("Rotate") {
                        withAnimation(.easeOut) {
                            rotation += 360
                            
                        }
                    }
                }
                .buttonStyle(.borderedProminent)
                .padding(20)
                .tint(.purple)
            }
        }
    }
}

#Preview {
    ContentView()
}
