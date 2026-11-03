import SwiftUI
import SwiftData
import Foundation

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Expense.meghanaDate, order: .reverse)
    private var expenses: [Expense]

    @State private var isShowingItemSheet = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses) { meghanaExpense in
                    ExpenseCell(stationaryExpense: meghanaExpense)
                }
                .onDelete(perform: deleteExpense)
            }
            .navigationTitle("Expenses")
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $isShowingItemSheet) {
                AddExpenseSheet()
            }
            .toolbar {
                if !expenses.isEmpty {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Add Expense", systemImage: "plus") {
                            isShowingItemSheet = true
                        }
                    }
                }
            }
            .overlay {
                if expenses.isEmpty {
                    ContentUnavailableView {
                        Label(
                            "No Expenses",
                            systemImage: "list.bullet.rectangle.portrait"
                        )
                    } description: {
                        Text("Start adding expenses to see your list.")
                    } actions: {
                        Button("Add Expense") {
                            isShowingItemSheet = true
                        }
                    }
                    .offset(y: -60)
                }
            }
        }
    }

    private func deleteExpense(at offsets: IndexSet) {
        for index in offsets {
            context.delete(expenses[index])
        }
    }
}

struct ExpenseCell: View {
    let stationaryExpense: Expense

    var body: some View {
        HStack {
            Text(
                stationaryExpense.meghanaDate,
                format: .dateTime.month(.abbreviated).day()
            )
            .frame(width: 70, alignment: .leading)

            Text(stationaryExpense.meghanaName)

            Spacer()

            Text(
                stationaryExpense.meghanaValue,
                format: .currency(code: "USD")
            )
        }
    }
}

struct AddExpenseSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context

    @State private var name = ""
    @State private var date = Date.now
    @State private var value = 0.0

    var body: some View {
        NavigationStack {
            Form {
                TextField("Meghana Expense Name", text: $name)

                DatePicker(
                    "Date",
                    selection: $date,
                    displayedComponents: .date
                )

                TextField(
                    "Value",
                    value: $value,
                    format: .number
                )
                .keyboardType(.decimalPad)
            }
            .navigationTitle("New Expense")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        saveExpense()
                    }
                    .disabled(
                        name.trimmingCharacters(
                            in: .whitespacesAndNewlines
                        ).isEmpty || value <= 0
                    )
                }
            }
        }
    }

    private func saveExpense() {
        let expense = Expense(
            meghanaName: name.trimmingCharacters(
                in: .whitespacesAndNewlines
            ),
            meghanaDate: date,
            meghanaValue: value
        )

        context.insert(expense)

        do {
            try context.save()
            dismiss()
            
        } catch {
            context.rollback()
            print("Failed to save expense: \(error.localizedDescription)")
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Expense.self, inMemory: true)
}



