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
        let amount: Double
        let currencyCode: String
        let date: Date
        
        var amountFormatted: String {
            return String.localizedStringWithFormat("%@ %.2f", currencyCode, amount)
        }
        
        var dateFormatted: String {
            return dateFormatter.string(from: date)
        }
    }
    
    let id: ExpenseId
    let category: CategoryViewModel
    let date: Date
    let subject: String
    let amount: Double
    let currencyCode: String
    let exchangeRate: ExchangeRate?
    
    init(id: ExpenseId,
         category: CategoryViewModel,
         date: Date,
         subject: String,
         amount: Double,
         currencyCode: String,
         exchangeRate: ExchangeRate? = nil) {
        self.id = id
        self.category = category
        self.date = date
        self.subject = subject
        self.amount = amount
        self.currencyCode = currencyCode
        self.exchangeRate = exchangeRate
    }
    
    var amountFormatted: String {
        return String.localizedStringWithFormat("%@ %.2f", currencyCode, amount)
    }
    
    var dateFormatted: String {
        return dateFormatter.string(from: date)
    }
}
