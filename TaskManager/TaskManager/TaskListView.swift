//
//  TaskListView.swift
//  TaskManager
//
//  Created by Meghana IOS on 06/10/26.
//




import SwiftUI
import CoreData

struct TaskListView: View {

    let title: String
    @FetchRequest(fetchRequest: CDTask.fetch()) var tasks
    @State private var selectedTask: CDTask? = nil
    @State private var inspectorIsShown: Bool = false
    @Environment(\.managedObjectContext) var viewContext
    var body: some View {
        List(tasks){task in
            TasksRow(task:task)
        }
        .navigationTitle(title)
        .toolbar {
            ToolbarItemGroup{
                Button{
                    _ = CDTask(title:"New",dueDate:Date(),context:context)
                    tasks.append(Task(title:"New tasks"))
                }label:{
                    Label("Add New task", systemImage: "plus")
                }
                Button{
                    inspectorIsShown.toggle()
                }label:{
                    Label("Show inspector",systemImage: "sidebar.right")
                }
            }
        }
    }
 }
#Preview {
    TaskListView(title: "All")
        .environment(
            \.managedObjectContext,
            PersistenceController.preview.container.viewContext
        )
}
