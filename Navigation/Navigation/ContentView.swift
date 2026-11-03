//import SwiftUI
//
//struct DetailView: View {
//    var number: Int
//    
//    init(number: Int) {
//        self.number = number
//        print("Creating detail view \(number)")
//    }
//    var body: some View {
//        Text("Detail View \(number)")
//    }
//}
//struct ContentView: View {
//    var body: some View {
//        NavigationStack {
//            List(0..<1000){ i in
//                NavigationLink("Tap Me",value: i)
//            }
//            .navigationDestination(for: Int.self){
//                number in
//                DetailView(number:number)
//            }
//        }
//    }
//}
//
//#Preview {
//    ContentView()
//}


import SwiftUI
struct ContentView: View {
    @State private var path = [Int]()
    var body: some View {
        NavigationStack(path:$path){
            VStack(spacing:20){
                Button("Show 32"){
                    path = [32]
                    print("value of path = \(path)")
                }
                Button("Show 64"){
                    path.append(64)
                    print("value of path = \(path)")
                }
                Button("Show 32 then 64"){
                    path = [32,64]
                    print("value of path = \(path)")
                }

            }
            .navigationTitle("Home")
            .navigationDestination(for:Int.self){ selection in
                Text("you selected \(selection)")
            }
        }
    }
}
