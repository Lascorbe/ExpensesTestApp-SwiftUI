//
//  RemoveExpense.swift
//  ExpensesTest
//
//  Created by Luis Ascorbe on 10/05/2020.
//  Copyright © 2020 Luis Ascorbe. All rights reserved.
//

import Foundation
import Storage

final class RemoveExpense: UseCase {
    private let client: ExpenseStorageClient
    
    init(client: ExpenseStorageClient = ExpenseStorageClient()) {
        self.client = client
    }
    
    func execute(expenseId: ExpenseId) {
        client.getExpensesByDate { [weak self] storageExpenses in
            let found = storageExpenses.first { $0.id == expenseId }
            if let storageExpense = found {
                self?.executeRemove(storageExpense)
            }
        }
    }
    
    private func executeRemove(_ storageExpense: Storage.Expense) {
        do {
            try client.remove(storageExpense)
            print("Expense removed: \(storageExpense)")
        } catch {
            assertionFailure("Error trying to remove expense in database: \(error.localizedDescription)")
        }
    }
}
