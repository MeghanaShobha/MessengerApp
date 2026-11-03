//
//  CDTaskGroup+helper.swift
//  TaskManager
//
//  Created by Meghana IOS on 06/10/26.
//

import Foundation

extention CDTaskGroup{
    var uuid: UUID {
        #if DEBUG
        uuid_!
        #else
        uuid_ ?? UUID()
        #endif
    }
    var title: String{
        get { title_ ?? "" }
        set { title_ = newValue }
    }
    var creationDate: Date {
        creationDate_ ?? Date()
    }
    convenience init(title:String,dueDate:Date,context:NSManagedObjectContext){
        self.init(context:context)
        self.title = title
        
    }
    public override func awakeFromInsert() {
        self.uuid_ = UUID()
        self.creationDate_ = Date()
    }
    static func delete(taskGroup:CDTaskGroup){
        guard let context = taskGroup.managedObjectContext else{return}
        context.delete(taskGroup)
    }
    static func fetch(_ predicate: NSPredicate =.all)-> NSFetchRequest<CDTaskGroup>{
        let request = CDTaskGroup.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \CDTaskGroup.title_, ascending: true),
                                   NSSortDescriptor(keyPath: \CDTaskGroup.creationDate_, ascending: true)]
        request.predicate = predicate
        return request
    }
    
    static var example : CDTaskGroup {
        let context = PersistenceController.preview.container.viewContext
        let taskGroup = CDTaskGroup(title: "Groceries", context: context)
        return taskGroup
    }
}
