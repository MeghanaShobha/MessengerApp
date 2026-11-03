import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var context

    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(key: "name", ascending: true)
        ],
        animation: .default
    )
    private var students: FetchedResults<Student>

    var body: some View {
        NavigationStack {
            List {
                Section("Students") {
                    ForEach(students) { student in
                        VStack(alignment: .leading) {
                            Text(student.name ?? "")
                                .font(.headline)

                            Text("Age: \(student.age)")
                            Text("Course: \(student.course ?? "")")
                        }
                    }
                }

                Section("CRUD") {
                    Button("Add Student") {
                        addStudent(context: context)
                    }

                    Button("Fetch Students") {
                        fetchStudents(context: context)
                    }

                    Button("Students Above 20") {
                        fetchStudentsAbove20(context: context)
                    }

                    Button("Update Meghana") {
                        updateStudent(context: context)
                    }

                    Button("Delete Meghana") {
                        deleteStudent(context: context)
                    }
                }
            }
            .navigationTitle("Student Manager")
        }
    }
}
