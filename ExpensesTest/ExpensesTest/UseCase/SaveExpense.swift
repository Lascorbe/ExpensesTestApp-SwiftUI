//
//  SaveExpense.swift
//  ExpensesTest
//
//  Created by Luis Ascorbe on 10/05/2020.
//  Copyright © 2020 Luis Ascorbe. All rights reserved.
//

import Foundation
import Storage

final class SaveExpense: UseCase {
    private let expenseClient: ExpenseStorageClient
    private let categoryClient: CategoryStorageClient
    
    init(expenseClient: ExpenseStorageClient = ExpenseStorageClient(), categoryClient: CategoryStorageClient = CategoryStorageClient()) {
        self.expenseClient = expenseClient
        self.categoryClient = categoryClient
    }
    
    func execute(expense: Expense) {
        let category = categoryClient.makeModel()
        let storageExpense = expenseClient.makeModel().setup(with: expense, category: category)
        do {
            try expenseClient.add(storageExpense)
            print("Expense saved: \(storageExpense)")
        } catch {
            assertionFailure("Error trying to save expense in database: \(error.localizedDescription)")
        }
    }
}
