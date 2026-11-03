//import SwiftUI
//
//struct ContentView: View {
//    @State private var showingsheet = false
//    var body: some View {
//       Button("Show sheet") {
//            showingsheet.toggle()
//        }
//       .sheet(isPresented: $showingsheet) {
//           SecondView()
//       }
//    }
//}
//struct SecondView: View {
//    var body: some View {
//        Text("Second view")
//    }
//}
//#Preview {
//    ContentView()
//}
//

import SwiftUI
struct ContentView: View {
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(numbers, id: \.self) {
                        Text("Row \($0)")
                    }
                    .onDelete(perform: removeRows)
                }
                Button("Add Numbers") {
                    numbers.append(currentNumber)
                    currentNumber += 1
                }
            }
            .toolbar {
                EditButton()
            }
        }
    }
    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}

//
//import SwiftUI
//struct User: Codable {
//    let firstName: String
//    let lastName: String
//}
//struct ContentView: View {
//    @State private var user = User(firstName: "Taylor", lastName: "Swift")
//    var body: some View {
//        VStack {
//            Text("\(user.firstName) \(user.lastName)")
//            Button("Save User") {
//                let encoder = JSONEncoder()
//                if let data = try? encoder.encode(user) {
//                    UserDefaults.standard.set(data, forKey: "UserData")
//                }
//            }
//            Button("Load User") {
//                let decoder = JSONDecoder()
//                if let data = UserDefaults.standard.data(forKey: "UserData") {
//                    if let savedUser = try? decoder.decode(User.self, from: data) {
//                        user = savedUser
//                    }
//                }
//            }
//        }
//    }
//}

//
//import SwiftUI
//import Observation
//
//struct ExpenseItem:Identifiable,Codable {
//    let id:UUID = UUID()
//    let name: String
//    let type: String
//    let amount: Double
//}
//@Observable
//class Expenses {
//    var items = [ExpenseItem](){
//        didSet{
//            if let encoded = try? JSONEncoder().encode(items) {
//                            UserDefaults.standard.set(encoded, forKey: "Items")
//                        }
//                    }
//                }
//                init() {
//                    if let savedItems = UserDefaults.standard.data(forKey: "Items") {
//                        if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
//                            items = decodedItems
//                            return
//                        }
//                    }
//                    items = []
//                }
//            }
//
//struct ContentView: View {
//    @State private var expenses = Expenses()
//    
//    var body: some View {
//        NavigationStack {
//            List {
//                ForEach(expenses.items, id: \.name) { item in
//                    Text(item.name)
//                }
//                .onDelete(perform: removeItems)
//            }
//            .navigationTitle("iExpense")
//            .toolbar {
//                Button("Add Expense", systemImage: "plus") {
//                    let expense = ExpenseItem(name: "Test", type: "Personal", amount: 5)
//                    expenses.items.append(expense)
//                }
//            }
//        }
//    }
//    func removeItems(at offsets: IndexSet) {
//        expenses.items.remove(atOffsets: offsets)
//    }
//}
