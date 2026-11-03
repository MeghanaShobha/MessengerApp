import SwiftUI

struct ContentView: View {
    @State private var images = [
        "appicon",
        "burgerIcon",
        "crown_icon",
        "dailyCalorieIcon",
        "stepsTakenIcon"
    ]
    
    var body: some View {
        NavigationStack {
            //            VStack {
            //                HStack {
            //                    Image(images[0])
            //                        .resizable()
            //                        .scaledToFit()
            //                        .frame(width: 50, height: 50)
            //
            //                    Text("Kk")
            //                        .font(.title)
            //                        .bold()
            //                        .foregroundColor(.brown)
            //
            //                    Spacer()
            //                    HStack(spacing:10) {
            //                        Image(images[3])
            //                            .resizable()
            //                            .scaledToFit()
            //                            .frame(width: 50, height: 50)
            //
            //                        Text("1")
            //                            .font(.title)
            //                            .bold()
            //                            .foregroundColor(.brown)
            //
            //                        Image(images[4])
            //                            .resizable()
            //                            .scaledToFit()
            //                            .frame(width: 50, height: 50)
            //
            //                        Image(images[2])
            //                            .resizable()
            //                            .scaledToFit()
            //                            .frame(width: 50, height: 50)
            //                    }
            //                    .frame(maxWidth: .infinity, alignment: .trailing)
            //                    .padding()
            //                }
            //                .padding()
            //
            //
            //
            //                Spacer()
            //            }
            //            .frame(maxWidth: .infinity, maxHeight: .infinity)
            //        }
            
            
            
            
            
            ZStack {
                Color(red: 1.0, green: 0.99, blue: 0.94)
                    .ignoresSafeArea()
                    .glassEffect()
                VStack{
                    HStack{
                        HStack{
                            AppImage(name: images[0], size:40)
                            Text("Kk")
                                .font(.title)
                                .bold()
                                .foregroundColor(.brown)
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 11)
                        .glassEffect()
                        .background(
                            Capsule()
                                .fill(Color(red: 1.0, green: 0.92, blue: 0.65))
                        )
                        HStack(spacing: 5) {
                            AppImage(name: images[3], size: 40)
                            Text("1")
                                .font(.title)
                                .bold()
                                .foregroundColor(.brown)
                            
                            AppImage(name: images[4], size: 45)
                            
                            AppImage(name: images[2], size: 40)
                            Menu {
                                Button("Share Snap") {
                                    print("Share Snap")
                                }
                                .buttonStyle(.glass)
                                Button("Talk to Buddy") {
                                    print("Talk to Buddy")
                                }
                            } label: {
                                AppImage(name: images[1], size: 40)
                                    .glassEffect()
                                    
                            }
                            
                            
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical,8)
                        .glassEffect()
                        .background(
                            Capsule()
                                .fill(Color(red: 1.0, green: 0.92, blue: 0.65))
                        )
                        
                    }
                    
                    .padding()
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}

struct AppImage:View{
    let name:String
    let size:CGFloat
    var body: some View{
        Image(name)
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
    }
}

#Preview {
    ContentView()
}
