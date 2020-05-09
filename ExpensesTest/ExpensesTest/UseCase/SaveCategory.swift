//
//  SaveCategory.swift
//  ExpensesTest
//
//  Created by Luis Ascorbe on 09/05/2020.
//  Copyright © 2020 Luis Ascorbe. All rights reserved.
//

import Foundation
import Storage

final class SaveCategory: UseCase {
    private let client: CategoryStorageClient
    
    init(client: CategoryStorageClient = CategoryStorageClient()) {
        self.client = client
    }
    
    func execute(category: Category) {
        let storageCategory = client.makeModel().setup(with: category)
        do {
            try client.add(storageCategory)
            print("Category saved: \(storageCategory)")
        } catch {
            assertionFailure("Error trying to save category in database: \(error.localizedDescription)")
        }
    }
}
