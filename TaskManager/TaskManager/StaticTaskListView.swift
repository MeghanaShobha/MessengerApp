//
//  StaticTaskListView.swift
//  TaskManager
//
//  Created by Meghana IOS on 06/10/26.
//

import SwiftUI
import CoreData

struct StaticTaskListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest private var tasks: FetchedResults<CDTask>
    
    @State private var selectedTask: CDTask?
    @State private var inspectorIsShown = false
    
    let title: String
    
    init(title: String, predicate: NSPredicate = .all) {
        self.title = title
        
        _tasks = FetchRequest(
            fetchRequest: CDTask.fetch(predicate),
            animation: .default
        )
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(title)
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "plus")
                }
                
                Button {
                    inspectorIsShown.toggle()
                } label: {
                    Image(systemName: "sidebar.right")
                }
                
                Button {
                    
                } label: {
                    Image(systemName: "magnifyingglass")
                }
            }
            .padding()
            
            Divider()
            
            List {
                ForEach(tasks) { task in
                    HStack {
                        Button {
                            task.isCompleted.toggle()
                            
                            do {
                                try viewContext.save()
                            } catch {
                                print(error.localizedDescription)
                            }
                        } label: {
                            Image(
                                systemName: task.isCompleted
                                ? "checkmark.circle.fill"
                                : "circle"
                            )
                        }
                        .buttonStyle(.plain)
                        
                        Text(task.title)
                        
                        Spacer()
                        
                        Button("More") {
                            selectedTask = task
                            inspectorIsShown = true
                        }
                        .buttonStyle(.borderless)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        selectedTask = task
                        inspectorIsShown = true
                    }
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        let task = tasks[index]
                        viewContext.delete(task)
                    }
                    
                    do {
                        try viewContext.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            .listStyle(.plain)
        }
        .navigationTitle("")
        .inspector(isPresented: $inspectorIsShown) {
            if let selectedTask {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Task Details")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text(selectedTask.title)
                        .font(.body)
                    
                    if let dueDate = selectedTask.dueDate {
                        Text(dueDate, style: .date)
                            .foregroundStyle(.secondary)
                    }
                    
                    Spacer()
                }
                .padding()
                .frame(minWidth: 250)
            }
        }
    }
}

#Preview {
    StaticTaskListView(title: "Done")
        .environment(
            \.managedObjectContext,
            PersistenceController.preview.container.viewContext
        )
}
