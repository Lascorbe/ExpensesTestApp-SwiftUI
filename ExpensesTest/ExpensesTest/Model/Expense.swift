//
//  Expense.swift
//  ExpensesTest
//
//  Created by Luis Ascorbe on 08/05/2020.
//  Copyright © 2020 Luis Ascorbe. All rights reserved.
//

import Foundation

typealias ExpenseId = UUID

struct Expense: Hashable {
    struct ExchangeRate: Hashable {
        let amount: Double
        let currencyCode: CurrencyCode
        let date: Date
    }
    
    let id: ExpenseId
    let category: Category
    let date: Date
    let subject: String
    let amount: Double
    let currencyCode: CurrencyCode
    var exchangeRate: ExchangeRate?
}
