import SwiftUI

struct ContentView: View {
    @State private var animationAmount = 1.0
    var body: some View {
        
        
                //1st way of animation
        //        VStack(spacing: 40){
        //            Spacer()
        //            Stepper(
        //                "Scale amount",
        //                value: $animationAmount.animation(),
        //                in: 1...10
        //            )
        //            .padding(90)
        //            Button("Tap me"){
        //                animationAmount += 1
        //
        //            }
        //            .padding(50)
        //            .background(.red)
        //            .foregroundStyle(.white)
        //            .clipShape(.circle)
        //            .overlay(
        //                Circle()
        //                    .stroke(.red)
        //                    .scaleEffect(animationAmount)
        //                    .opacity(2 - animationAmount)
        //                    .animation(
        //                        .easeInOut(duration: 1)
        //                        .repeatForever(autoreverses: false),
        //                        value:animationAmount
        //                    )
        //
        //            )
        //            .onAppear {
        //                animationAmount = 2
        //            }
        //            Spacer()
        //        }
        
        
        
        //2nd way of animation
        Button("Tap Me") {
            withAnimation {
                animationAmount += 360
            }
        }
        .padding(50)
        .background(.red)
        .foregroundStyle(.white)
        .clipShape(.circle)
        .rotation3DEffect(
            .degrees(animationAmount),
            axis: (x: 1, y: 1, z: 1)
        )
    }
}

#Preview {
    ContentView()
}
    



//import SwiftUI
//
//struct ContentView: View {
//
//    @State private var viewScale = 1.0
//    @State private var bindingScale = 1.0
//    @State private var rotationAmount = 0.0
//var body: some View {
//        VStack(spacing: 40) {
//            VStack {
//                Text("View Animation")
//                Button("Tap Me") {
//                    viewScale += 0.5
//                }
//                .padding()
//                .background(.red)
//                .foregroundStyle(.white)
//                .clipShape(.capsule)
//                .scaleEffect(viewScale)
//                .animation(.easeInOut, value: viewScale)
//            }
//            Divider()
//            VStack {
//                Text("Binding Animation")
//                Stepper(
//                    "Scale: \(bindingScale)",
//                    value: $bindingScale.animation(),
//                    in: 1...3,
//                    step: 0.5
//                )
//                Circle()
//                    .fill(.blue)
//                    .frame(width: 100, height: 100)
//                    .scaleEffect(bindingScale)
//            }
//            Divider()
//            VStack {
//                Text("Explicit Animation")
//                Button("Rotate Me") {
//                    withAnimation(.spring(duration: 1,bounce: 0.3)) {
//                        rotationAmount += 360
//                    }
//                }
//                .padding()
//                .background(.green)
//                .foregroundStyle(.white)
//                .clipShape(.capsule)
//                .rotation3DEffect(
//                    .degrees(rotationAmount),
////                    axis: (x: 1, y: 0, z: 0)
//                    axis: (x: 0, y: 1, z: 0)
////                    axis: (x: 0, y: 0, z: 1)
//                )
//            }
//        }
//        .padding()
//    }
//}
//
//#Preview {
//    ContentView()
//}




//import SwiftUI
//
//struct ContentView: View {
//    @State private var isShowingRed = false
//    var body: some View {
//        VStack(spacing: 30) {
//            Button("Tap Me") {
//                withAnimation {
//                    isShowingRed.toggle()
//                }
//            }
//            .background(Color.yellow)
//            .padding(60)
//            .cornerRadius(20)
//            
//            if isShowingRed {
//                Rectangle()
//                    .fill(.red)
//                    .frame(width: 200, height: 200)
//                    .transition(
//                        .asymmetric(
//                            insertion: .scale,
//                            removal: .opacity
//                        )
//                    )
//            }
//        }
//    }
//}
//
//#Preview {
//    ContentView()
//}
