//
//  CDTask+helper.swift
//  TaskManager
//
//  Created by Meghana IOS on 06/10/26.
//

import Foundation
extension CDTask {
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
    
    var dueDate: Date? {
        get { dueDate_ ?? date() }
        set { dueDate_ = newValue }
    }
    convenience init(title:String,dueDate:Date,context:NSManagedObjectContext){
        self.init(context:context)
        self.title = title
        self.dueDate = dueDate
    }
    public override func awakeFromInsert() {
        self.uuid_ = UUID()
        
    }
    static func delete(task:CDTask){
        guard let context = task.managedObjectContext else{return}
        context.delete(task)
    }
    
    static func fetch(_ predicate: NSPredicate =.all)-> NSFetchRequest<CDTask>{
        let request = CDTask.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \CDTask.dueDate_, ascending: true),
                                   NSSortDescriptor(keyPath: \CDTask.title_, ascending: true)]
        request.predicate = predicate
        return request
    }
    //mark: - preview helpers
    static var example : CDTask {
        let context = PersistenceController.preview.container.viewContext
        let task = CDTask(title: "By cat food", dueDate: Date(), context: context)
        return task
    }
        
    
}
