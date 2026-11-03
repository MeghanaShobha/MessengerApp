//
//  TaskSection.swift
//  TaskManager
//
//  Created by Meghana IOS on 06/10/26.
//

import Foundation
enum TaskSection: Identifiable,Hashable, CaseIterable {
    case all
    case done
    case upcoming
    case list(CDTaskGroup)
    
    
    var id : String{
        Switch self{
        case .all:
            "all"
        case .done:
            "done"
        case .upcoming:
            "upcoming"
        case .list(let taskGroup):
            taskGroup.uuid.uuidString
        }
    }
    var displayName: String {
        Switch self{
        case .all:
            "All"
        case .done:
            "Done"
        case .upcoming:
            "Upcoming"
        case .list(let taskGroup):
            taskGroup.name
        }
    }
    var iconName:String{
        switch self {
            case .all:
                "star"
            case .done:
            "checkmark.circle"
        case .upcoming:
            "calendar"
        case .list:
            "list.bullet"
        }
    }
}
#Preview{
    SidebarView(selection: .constant(.all))
    .listStyle(.sidebar)
    .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
