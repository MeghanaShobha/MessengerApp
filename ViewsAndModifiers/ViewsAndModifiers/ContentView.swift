import SwiftUI

struct ProfileCard: View {
    var body: some View {
        VStack(spacing: 4) {
            Text("Meghana")
            Text("iOS Developer")
                .foregroundStyle(.blue)
        }
        .padding()
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .navigationTitle("Profile Detail")
        .padding()
    }
}

struct ContentView: View {
    @State private var useRedText = false
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
               Button {
                    print("hello, world")
                } label: {
                    Text("press me ")
                        .font(.system(size: 60))
                        .padding()
                        .colorMultiply(Color.blue)
                }
                .background(Color.red)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                NavigationLink {
                    ProfileCard()
                } label: {
                    Text("Profile")
                        .foregroundStyle(useRedText ? .black : .black)
                        .padding(30)
                        .background(Color.green)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                
                Text("Modifier Order Example")
                    .padding()
                    .background(.yellow)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                Button("hello, world") {
                    useRedText.toggle()
                    print(type(of: self.body))
                }
                .padding(.horizontal, 5)
                .padding(.vertical, 2)
                .padding(54)
                .foregroundStyle(useRedText ? .red : .blue)
                .background(useRedText ? Color.red.opacity(0.15) : Color.blue.opacity(0.15))
                .clipShape(Capsule())
            }
            .padding()
            .navigationTitle("Main Screen")
            .font(.headline)
            .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    ContentView()
}
