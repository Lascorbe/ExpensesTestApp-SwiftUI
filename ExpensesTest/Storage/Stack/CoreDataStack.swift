//
//  CoreDataStack.swift
//  Storage
//
//  Created by Luis Ascorbe on 08/05/2020.
//  Copyright © 2020 Luis Ascorbe. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    var viewContext: NSManagedObjectContext { persistentContainer.viewContext }
    
    private let containerName: String
    private let persistentContainer: NSPersistentContainer
    
    init(containerName: String) {
        self.containerName = containerName
        guard let modelURL = Bundle(for: Self.self).url(forResource: containerName, withExtension: "momd") else {
            fatalError("Error loading model from bundle")
        }
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Error initializing NSManagedObjectModel from: \(modelURL)")
        }
        self.persistentContainer = NSPersistentContainer(name: containerName, managedObjectModel: managedObjectModel)
    }
    
    func load(completion: @escaping (Error?) -> Void) {
        persistentContainer.loadPersistentStores(completionHandler: { (persistentStoreDescription, error) in
            if let error = error as NSError? {
                print(error.localizedDescription)
                assertionFailure("NSPersistentContainer failed to load persistent stores")
                completion(error)
            }
            print(persistentStoreDescription)
            completion(nil)
        })
    }
}

extension NSManagedObjectContext {
    func saveContext() throws {
        guard hasChanges else { return }
        try save()
    }
}
