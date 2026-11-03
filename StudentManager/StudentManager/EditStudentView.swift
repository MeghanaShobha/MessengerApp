
import SwiftUI
import CoreData

struct EditStudentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss

    @ObservedObject var student: Student

    @State private var name: String
    @State private var age: String
    @State private var course: String

    init(student: Student) {
        self.student = student
        _name = State(initialValue: student.name ?? "")
        _age = State(initialValue: String(student.age))
        _course = State(initialValue: student.course ?? "")
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Student Details") {
                    TextField("Name", text: $name)

                    TextField("Age", text: $age)
                        .keyboardType(.numberPad)

                    TextField("Course", text: $course)
                }

                Section {
                    Button("Update Student") {
                        updateStudent()
                    }
                    .disabled(
                        name.trimmingCharacters(in: .whitespaces).isEmpty ||
                        course.trimmingCharacters(in: .whitespaces).isEmpty ||
                        Int16(age) == nil ||
                        (Int16(age) ?? -1) < 0
                    )
                }
            }
            .navigationTitle("Edit Student")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }

    private func updateStudent() {
        guard
            !name.trimmingCharacters(in: .whitespaces).isEmpty,
            !course.trimmingCharacters(in: .whitespaces).isEmpty,
            let studentAge = Int16(age),
            studentAge >= 0
        else {
            return
        }

        student.name = name.trimmingCharacters(in: .whitespaces)
        student.age = studentAge
        student.course = course.trimmingCharacters(in: .whitespaces)

        do {
            try viewContext.save()
            dismiss()
        } catch {
            viewContext.rollback()
            print("Update failed: \(error.localizedDescription)")
        }
    }
}

#Preview {
    EditStudentView(student: {
        let context = PersistenceController.preview.container.viewContext
        let student = Student(context: context)
        student.name = "Meghana"
        student.age = 25
        student.course = "iOS"
        return student
    }())
    .environment(
        \.managedObjectContext,
        PersistenceController.preview.container.viewContext
    )
}
