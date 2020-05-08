//
//  ExpenseStorageClient.swift
//  Storage
//
//  Created by Luis Ascorbe on 08/05/2020.
//  Copyright © 2020 Luis Ascorbe. All rights reserved.
//

import CoreData

public final class ExpenseStorageClient {
    public typealias Model = Expense
    
    public var context: NSManagedObjectContext { StorageClient.shared.coreDataStack.viewContext }
    
    public init() {}
    
    public func getExpensesByDate(_ ascending: Bool = false, completion: @escaping ([Model]) -> Void) {
        let sortDescriptor = NSSortDescriptor(keyPath: \Model.date, ascending: ascending)
        let fetchRequest = NSFetchRequest<Model>(entityName: Model.entity().name ?? "Expense")
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        context.perform {
            do {
                let results = try fetchRequest.execute()
                completion(results)
            } catch let error as NSError {
                print(error.localizedDescription)
                completion([])
            }
        }
    }
    
    public func add(_ model: Model) throws {
        context.insert(model)
        try context.saveContext()
    }
    
    public func remove(_ model: Model) throws {
        context.delete(model)
        try context.saveContext()
    }
}
