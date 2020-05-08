//
//  CategoryStorageClient.swift
//  Storage
//
//  Created by Luis Ascorbe on 08/05/2020.
//  Copyright © 2020 Luis Ascorbe. All rights reserved.
//

import CoreData

public final class CategoryStorageClient {
    public typealias Model = Category
    
    public var context: NSManagedObjectContext { StorageClient.shared.coreDataStack.viewContext }
    
    public init() {}
    
    public func getCategories(completion: @escaping ([Model]) -> Void) {
        let fetchRequest = NSFetchRequest<Model>(entityName: Model.entity().name ?? "Category")
        
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
}
