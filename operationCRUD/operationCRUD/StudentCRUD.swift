//
//  StudentCRUD.swift
//  operationCRUD
//
//  Created by Meghana IOS on 05/10/26.
//

import CoreData

//
//@objc(Student)
//public class Student: NSManagedObject {
//}
//
//extension Student {
//    @nonobjc public class func fetchRequest() -> NSFetchRequest<Student> {
//        return NSFetchRequest<Student>(entityName: "Student")
//    }
//
//    @NSManaged public var name: String?
//    @NSManaged public var age: Int16
//    @NSManaged public var course: String?
//}

func addStudent(context: NSManagedObjectContext) {
    let student = Student(context: context)

    student.name = "Meghana"
    student.age = 25
    student.course = "iOS"

    do {
        try context.save()
        print("Student added successfully")
    } catch {
        print(error.localizedDescription)
    }
}

func fetchStudents(context: NSManagedObjectContext) {
    let request = Student.fetchRequest()

    request.sortDescriptors = [
        NSSortDescriptor(key: "name", ascending: true)
    ]

    do {
        let students = try context.fetch(request)

        for student in students {
            print(student.name ?? "")
            print(student.age)
            print(student.course ?? "")
        }
    } catch {
        print(error.localizedDescription)
    }
}

func fetchStudentsAbove20(context: NSManagedObjectContext) {
    let request = Student.fetchRequest()

    request.predicate = NSPredicate(
        format: "age > %d",
        20
    )

    request.sortDescriptors = [
        NSSortDescriptor(key: "age", ascending: true)
    ]

    do {
        let students = try context.fetch(request)

        for student in students {
            print("Name: \(student.name ?? "")")
            print("Age: \(student.age)")
            print("Course: \(student.course ?? "")")
        }
    } catch {
        print("Failed to fetch students: \(error.localizedDescription)")
    }
}

func updateStudent(context: NSManagedObjectContext) {
    let request = Student.fetchRequest()

    request.predicate = NSPredicate(
        format: "name == %@",
        "Meghana"
    )

    do {
        let students = try context.fetch(request)

        if let student = students.first {
            student.age = 26
            student.course = "SwiftUI"

            try context.save()

            print("Student updated successfully")
        } else {
            print("Student not found")
        }
    } catch {
        print("Failed to update student: \(error.localizedDescription)")
    }
}

func deleteStudent(context: NSManagedObjectContext) {
    let request = Student.fetchRequest()

    request.predicate = NSPredicate(
        format: "name == %@",
        "Meghana"
    )

    do {
        let students = try context.fetch(request)

        if let student = students.first {
            context.delete(student)

            try context.save()

            print("Student deleted successfully")
        } else {
            print("Student not found")
        }
    } catch {
        print("Failed to delete student: \(error.localizedDescription)")
    }
}




