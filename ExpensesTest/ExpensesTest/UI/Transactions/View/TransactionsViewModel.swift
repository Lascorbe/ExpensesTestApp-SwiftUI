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
        let dateString: String
    }
    
    let id: ExpenseId
    let category: CategoryViewModel
    let date: Date
    let dateString: String
    let subject: String
    let amount: String
    let exchangeRate: ExchangeRate?
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
        self.date = model.date
        self.dateString = dateFormatter.string(from: model.date)
        self.subject = model.subject
        self.amount = String.localizedStringWithFormat("%@ %.2f", model.currencyCode.rawValue, model.amount)
        self.exchangeRate = ExchangeRate(model.exchangeRate)
    }
}

extension TransactionViewModel.ExchangeRate {
    init?(_ model: Expense.ExchangeRate?) {
        guard let model = model else { return nil }
        self.amount = String.localizedStringWithFormat("%@ %.2f", model.currencyCode.rawValue, model.amount)
        self.dateString = relativeDateFormatter.localizedString(for: model.date, relativeTo: Date())
    }
}
