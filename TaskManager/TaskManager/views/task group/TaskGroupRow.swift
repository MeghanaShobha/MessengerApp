//
//  TaskGroupRow.swift
//  TaskManager
//
//  Created by Meghana IOS on 06/10/26.
//

import SwiftUI
struct TaskGroupRow: View {
    
    @ObservedObject var taskGroup: CDTaskGroup
    var body: some View {
        HStack{
            Image(systemName: "folder")
            TextField("New Group",text:$taskGroup.title)
        }
    }
}
#Preview {
    TaskGroupRow(taskGroup:CDTaskGroup.example)
}
