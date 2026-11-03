
import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Student.name, ascending: true)
        ],
        animation: .default
    )
    private var students: FetchedResults<Student>

    @State private var name = ""
    @State private var age = ""
    @State private var course = ""
    @State private var selectedStudent: Student?
    @State private var showEditSheet = false
    @State private var showAlert = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                GroupBox("Add Student") {
                    VStack(spacing: 12) {
                        TextField("Student name", text: $name)
                            .textFieldStyle(.roundedBorder)

                        TextField("Age", text: $age)
                            .keyboardType(.numberPad)
                            .textFieldStyle(.roundedBorder)

                        TextField("Course", text: $course)
                            .textFieldStyle(.roundedBorder)

                        Button("Add Student", action: addStudent)
                            .buttonStyle(.borderedProminent)
                    }
                    .padding(.vertical, 6)
                }
                .padding(.horizontal)

                List {
                    ForEach(students, id: \.objectID) { student in
                        HStack {
                            VStack(alignment: .leading, spacing: 5) {
                                Text(student.name ?? "No name")
                                    .font(.headline)

                                Text("Age: \(student.age)")

                                Text(student.course ?? "No course")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }

                            Spacer()

                            Button {
                                selectedStudent = student
                                showEditSheet = true
                            } label: {
                                Image(systemName: "pencil")
                                    .foregroundStyle(.blue)
                            }
                            .buttonStyle(.borderless)
                        }
                    }
                    .onDelete(perform: deleteStudents)
                }
                .listStyle(.plain)
            }
            .navigationTitle("Student Manager")
            .sheet(item: $selectedStudent) { student in
                EditStudentView(student: student)
                    .environment(\.managedObjectContext, viewContext)
            }
            .alert("Invalid Details", isPresented: $showAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text("Enter a name, a valid age, and a course.")
            }
        }
    }

    private func addStudent() {
        guard
            !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
            let studentAge = Int16(age),
            studentAge >= 0,
            !course.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        else {
            showAlert = true
            return
        }

        let student = Student(context: viewContext)
        student.name = name.trimmingCharacters(in: .whitespacesAndNewlines)
        student.age = studentAge
        student.course = course.trimmingCharacters(in: .whitespacesAndNewlines)

        saveContext()

        name = ""
        age = ""
        course = ""
    }

    private func deleteStudents(at offsets: IndexSet) {
        for index in offsets {
            viewContext.delete(students[index])
        }

        saveContext()
    }

    private func saveContext() {
        do {
            if viewContext.hasChanges {
                try viewContext.save()
            }
        } catch {
            viewContext.rollback()
            print("Core Data save failed: \(error.localizedDescription)")
        }
    }
}

#Preview {
    ContentView()
        .environment(
            \.managedObjectContext,
            PersistenceController.preview.container.viewContext
        )
}
