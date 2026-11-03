//
//  ContentView.swift
//  TaskManager
//
//  Created by Meghana IOS on 06/10/26.
//

import SwiftUI
import CoreData

struct ContentView: View {
    let persistenceController = PersistenceController.shared
    @State private var selection:TaskSelection? = TaskSelection.initialValue
    @State private var userCreatedGroups: [TaskGroup] = Taskgroup.examples()
    @State private var searchTeam: String = ""

    var body: some View {
        NavigationSplitView{
            SidebarView(selection:$selection)
                .navigationTitle(Text("Your Task"))
        }detail:{
            if searchTeam.isEmpty{
                switch selection {
                case .all:
                    TaskListView(title:"All")
                case .done:
                    StaticTaskListView(title:"All",tasks:allTasks.filter({
                        $0.iscompleted}))
                case .upcoming:
                    StaticTaskListView(title:"All",tasks:allTasks.filter({
                        !$0.iscompleted}))
                case .list(let taskGroup):
//                    StaticTaskListView(title:taskGroup.title,tasks:taskGroup.tasks)
                    Text("Placeholder")
                case .none:
                    Text("none")
                }
                }else{
                    StaticTaskListView(title:"All",tasks:allTasks.filter({
                        $0.title.contains(searchTeam)}))
            }
        }
        .searchable(text:$searchTeam)
        .environment(\.managedObjectContext, persistenceController.container.viewContext)
    }
}


#Preview {
    ContentView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
