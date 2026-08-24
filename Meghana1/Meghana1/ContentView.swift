import SwiftUI

struct ContentView: View {

    @State private var isActionClicked = false
    @State private var isSubmitClicked = false

    var body: some View {
        VStack {
            Image(systemName: "person")
                .imageScale(.large)
                .foregroundStyle(.tint)

            Text("AI/ML is a programming language")

            Button("Action") {
                isActionClicked.toggle()
            }
            .padding()
            .background(isActionClicked ? Color.green : Color.blue)
            .foregroundColor(.white)
            .cornerRadius(30)

            Button("Submit") {
                isSubmitClicked.toggle()
            
            }
            .padding(25)
            .background(isSubmitClicked ? Color.cyan:Color.orange)
            .foregroundColor(.black)
            .cornerRadius(20)
        }
        .padding()
        .onAppear {
            print("This is Swift code")
        }
    }
}

#Preview {
    ContentView()
}
