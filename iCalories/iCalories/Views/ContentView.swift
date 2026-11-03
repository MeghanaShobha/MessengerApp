import SwiftUI
internal import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext

    @FetchRequest(
        sortDescriptors: [
            SortDescriptor(\.date, order: .reverse)
        ]
    ) var foods: FetchedResults<Food>

    @State private var showingAddView = false

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("\(Int(totalCaloriesToday())) Kcal (Today)")
                    .foregroundColor(.gray)
                    .padding(.horizontal)

                List {
                    ForEach(foods) { food in
                        NavigationLink(destination: EditFoodView(food: food)) {
                            HStack {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(food.name ?? "")
                                        .bold()

                                    Text("\(Int(food.calories))")
                                        .foregroundColor(.red)
                                    + Text(" Calories")
                                }

                                Spacer()

                                Text(calcTimeSince(date: food.date ?? Date()))
                                    .foregroundColor(.gray)
                                    .italic()
                            }
                        }
                    }
                    .onDelete(perform: deleteFood)
                }
            }
            .navigationTitle("iCalories")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddView.toggle()
                    } label: {
                        Label("Add Food", systemImage: "plus.circle")
                    }
                }
            }
        }
        .sheet(isPresented: $showingAddView) {
            AddFoodView()
        }
        .navigationViewStyle(.stack)
    }

    private func deleteFood(at offsets: IndexSet) {
        withAnimation {
            offsets.map { foods[$0] }.forEach(managedObjectContext.delete)

            do {
                try managedObjectContext.save()
            } catch {
                print("Delete failed: \(error.localizedDescription)")
            }
        }
    }

    private func totalCaloriesToday() -> Double {
        var caloriesToday: Double = 0

        for item in foods {
            if let date = item.date,
               Calendar.current.isDateInToday(date) {
                caloriesToday += item.calories
            }
        }

        return caloriesToday
    }

    private func calcTimeSince(date: Date) -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: date, relativeTo: Date())
    }
}

#Preview {
    ContentView()
        .environment(
            \.managedObjectContext,
            DataController().container.viewContext
        )
}
