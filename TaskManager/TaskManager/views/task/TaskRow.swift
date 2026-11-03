//
//  TaskRow.swift
//  TaskManager
//
//  Created by Meghana IOS on 06/10/26.
//

import SwiftUI
struct TaskRow: View {
    @ObservedObject var task: CDTask
    var body: some View {
        HStack {
            Image(systemName: task.isCompleted ? "large.circle.fill" : "circle")
                .onTapGesture {task.isCompleted.toggle() }
            TextField("New Task",text:$task.title)
                .textFieldStyle(.plain)
            Button(action:{
                
            },label: {
                Text("More")
            })
        }
    }
}
#Preview {
    TaskRow(task: CDTask.example)
        .padding()
}
