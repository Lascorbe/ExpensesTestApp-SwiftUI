//
//  GetCategories.swift
//  ExpensesTest
//
//  Created by Luis Ascorbe on 09/05/2020.
//  Copyright © 2020 Luis Ascorbe. All rights reserved.
//

import Foundation
import Storage

final class GetCategories: UseCase {
    private let client: CategoryStorageClient
    
    init(client: CategoryStorageClient = CategoryStorageClient()) {
        self.client = client
    }
    
    func execute(completion: @escaping ([Category]) -> Void) {
        client.getCategories { storageCategories in
            let list = storageCategories.map { Category($0) }
            completion(list)
        }
    }
}
