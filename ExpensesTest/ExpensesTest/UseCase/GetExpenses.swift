//
//  GetExpenses.swift
//  ExpensesTest
//
//  Created by Luis Ascorbe on 09/05/2020.
//  Copyright © 2020 Luis Ascorbe. All rights reserved.
//

import Foundation
import Storage

final class GetExpenses: UseCase {
    private let client: ExpenseStorageClient
    private let getCurrencies = GetCurrencies().execute
    private let getExchangeRate = GetExchangeRate().execute
    
    init(client: ExpenseStorageClient = ExpenseStorageClient()) {
        self.client = client
    }
    
    func execute(completion: @escaping ([Expense]) -> Void) {
        getCurrencies { [weak self] currencies in
            self?.client.getExpensesByDate { storageExpenses in
                let list: [Expense] = storageExpenses.map {
                    var expense = Expense($0)
                    if expense.currencyCode == .USD, let currencies = currencies {
                        let exchangeRate = self?.getExchangeRate(.NZD, expense.amount, currencies)
                        expense.exchangeRate = exchangeRate
                    }
                    return expense
                }
                completion(list)
            }
        }
    }
}
