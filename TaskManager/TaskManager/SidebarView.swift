//
//  SidebarView.swift
//  TaskManager
//
//  Created by Meghana IOS on 06/10/26.
//
import SwiftUI
import CoreData

struct SidebarView : View {
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(fetchRequest: CDTaskGroup.fetch(), animation: .bouncy)
    var taskGroup: FetchedResults<CDTaskGroup>
   
    @Binding var selection: TaskSection?
    
    var body: some View {
        List(selection:$selection) {
            Section("Favorites") {
                ForEach(TaskSection.allCases){
                    selection in
                    Label(selection.displayName,
                          systemImage:selection.iconName)
                    .tag(selection)
                }
                Selection("Your Groups"){
                    ForEach(taskGroups){
                        group in
                        TaskGroupRow(taskGroup:group)
                        .tag(TaskSection.list(group))
                        .contextMenu {
                            Button("Delete",role: .destructive){
                                CDTaskGroup.delete(taskGroup: group)
                                }
                            }
                        }
                    }
                }
            }
            .safeAreaInsert(edge: .bottom){
                Button(action:{
                    let newGroup = CDTaskGroup(title: "New Group", context: context)
                    
                },label:{
                    Label("Add Group",systemImage:"plus.circle")
                })
                .buttonStyle(.borderless)
                .foregroundColor(.accentColor)
                .padding()
                .frame(maxWidth:.infinity,alignment:.leading)
                .background(in: .thickMaterial)
                .keyboardShortcut(KeyEquivalent("a"),modifiers: .command)
            }
        }
        
    }
}
#Preview {
    SidebarView(userCreatedGroups: .constant(TaskGroup.examples()), selection: .constant(.all))
        .listStyle(.sidebar)
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext))
}
