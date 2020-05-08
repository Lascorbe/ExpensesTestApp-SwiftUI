//
//  StorageClient.swift
//  Storage
//
//  Created by Luis Ascorbe on 08/05/2020.
//  Copyright © 2020 Luis Ascorbe. All rights reserved.
//

import Foundation

public final class StorageClient {
    public static func start() {
        _ = StorageClient.shared
    }
    static let shared = StorageClient()
    
    let coreDataStack: CoreDataStack
    
    init(coreDataStack: CoreDataStack = CoreDataStack(containerName: "Expenses")) {
        self.coreDataStack = coreDataStack
        NotificationCenter.default.addObserver(self, selector: #selector(save), name: NSNotification.Name(rawValue: "sceneDidEnterBackground"), object: nil)
    }
    
    @objc func save() throws {
        try coreDataStack.viewContext.saveContext()
    }
}
