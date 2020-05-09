//
//  TransactionsViewModel.swift
//  ExpensesTest
//
//  Created by Luis Ascorbe on 07/05/2020.
//  Copyright © 2020 Luis Ascorbe. All rights reserved.
//

import Foundation

struct TransactionsViewModel: Hashable {
    var transactions: [TransactionViewModel]
}

struct TransactionViewModel: Hashable {
    struct ExchangeRate: Hashable {
        let amount: String
        let date: String
    }
    
    let id: ExpenseId
    let category: CategoryViewModel
    let date: String
    let subject: String
    let amount: String
    let exchangeRate: ExchangeRate?
    
    init(id: ExpenseId,
         category: CategoryViewModel,
         date: String,
         subject: String,
         amount: String,
         exchangeRate: ExchangeRate? = nil) {
        self.id = id
        self.category = category
        self.date = date
        self.subject = subject
        self.amount = amount
        self.exchangeRate = exchangeRate
    }
}

// MARK: Mappers

extension TransactionsViewModel {
    init(_ models: [Expense]) {
        self.transactions = models.map { TransactionViewModel($0) }
    }
}

extension TransactionViewModel {
    init(_ model: Expense) {
        self.id = model.id
        self.category = CategoryViewModel(model.category)
        self.date = dateFormatter.string(from: model.date)
        self.subject = model.subject
        self.amount = String.localizedStringWithFormat("%@ %.2f", model.currencyCode.rawValue, model.amount)
        self.exchangeRate = ExchangeRate(model.exchangeRate)
    }
}

extension TransactionViewModel.ExchangeRate {
    init?(_ model: Expense.ExchangeRate?) {
        guard let model = model else { return nil }
        self.amount = String.localizedStringWithFormat("%@ %.2f", model.currencyCode.rawValue, model.amount)
        self.date = relativeDateFormatter.localizedString(for: model.date, relativeTo: Date())
    }
}
