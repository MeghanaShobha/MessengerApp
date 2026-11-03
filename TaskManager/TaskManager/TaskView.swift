//
//  TaskView.swift
//  TaskManager
//
//  Created by Meghana IOS on 06/10/26.
//

import SwiftUI
struct TaskView: View {
    @Binding var task: Task
    @Binding var SelectedTask: Task?
    @Binding var inspectorIsShown: Bool
    var body: some View {
        HStack {
            Image(systemName: task.isCompleted ? "largecircle.fill.circle": "circle")
                .onTapGesture{
                    task.isCompleted.toggle()
                }
            TaskField("New Task",text:$task.title)
                .textFieldStyle(.plain)
            Button(action:{
                inspectorIsShown = true
                SelectedTask = task
             },label: {
                 Task("More")
             }
            )
        }
    }
}
