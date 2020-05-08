//
//  SetupStorage.swift
//  ExpensesTest
//
//  Created by Luis Ascorbe on 08/05/2020.
//  Copyright © 2020 Luis Ascorbe. All rights reserved.
//

import Foundation
import Storage

final class SetupStorage: UseCase {
    private let setupCategories = SetupCategoriesIfNeeded().execute
    
    func execute() {
        StorageClient.start { [weak self] error in
            guard error == nil else { return }
            self?.setupCategories()
        }
    }
}
