
import CoreData
import SwiftUI

struct PersistenceController {
    static let shared = PersistenceController()
    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "StudentModel")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Core Data failed: \(error.localizedDescription)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}

@objc(Student)
public class Student: NSManagedObject {
}

extension Student {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Student> {
        NSFetchRequest<Student>(entityName: "Student")
    }

    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    @NSManaged public var course: String?
}

extension Student: Identifiable {
}

@main
struct StudentApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(
                    \.managedObjectContext,
                    persistenceController.container.viewContext
                )
        }
    }
}

struct ContentView: View {
    @Environment(\.managedObjectContext) private var context

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

    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                TextField("Name", text: $name)
                    .textFieldStyle(.roundedBorder)

                TextField("Age", text: $age)
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)

                TextField("Course", text: $course)
                    .textFieldStyle(.roundedBorder)

                Button("Add Student") {
                    addStudent()
                }
                .buttonStyle(.borderedProminent)

                List {
                    ForEach(students) { student in
                        VStack(alignment: .leading, spacing: 5) {
                            Text(student.name ?? "No Name")
                                .font(.headline)

                            Text("Age: \(student.age)")
                            Text("Course: \(student.course ?? "No Course")")
                        }
                        .swipeActions {
                            Button("Delete", role: .destructive) {
                                deleteStudent(student)
                            }
                        }
                    }
                    .onDelete(perform: deleteStudents)
                }
            }
            .padding()
            .navigationTitle("Students")
        }
    }

    private func addStudent() {
        let student = Student(context: context)

        student.name = name
        student.age = Int16(age) ?? 0
        student.course = course

        do {
            try context.save()
            name = ""
            age = ""
            course = ""
        } catch {
            print("Save failed: \(error.localizedDescription)")
        }
    }

    private func deleteStudent(_ student: Student) {
        context.delete(student)

        do {
            try context.save()
        } catch {
            print("Delete failed: \(error.localizedDescription)")
        }
    }

    private func deleteStudents(at offsets: IndexSet) {
        for index in offsets {
            context.delete(students[index])
        }

        do {
            try context.save()
        } catch {
            print("Delete failed: \(error.localizedDescription)")
        }
    }
}
