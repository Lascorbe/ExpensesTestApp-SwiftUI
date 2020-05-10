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
    
    var context: NSManagedObjectContext { storageClient.coreDataStack.viewContext }
    
    private let storageClient: StorageClient
    
    public init(storageClient: StorageClient = StorageClient.shared) {
        self.storageClient = storageClient
    }
    
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
    
    public func add(list: [Model]) throws {
        for model in list {
            context.insert(model)
        }
        try context.saveContext()
    }
    
    public func remove(_ model: Model) throws {
        context.delete(model)
        try context.saveContext()
    }
    
    public func makeModel() -> Model {
        return Model(context: context)
    }
}
