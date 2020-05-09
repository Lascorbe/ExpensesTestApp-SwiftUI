//
//  Expense.swift
//  ExpensesTest
//
//  Created by Luis Ascorbe on 08/05/2020.
//  Copyright © 2020 Luis Ascorbe. All rights reserved.
//

import Foundation
import Storage

extension ExpensesTest.Expense {
    init(_ model: Storage.Expense) {
        self.id = model.id
        self.category = Category(model.category)
        self.date = model.date
        self.amount = Double(truncating: model.amount)
        self.currencyCode = CurrencyCode(rawValue: model.currencyCode)!
        self.subject = model.subject
    }
}



extension Storage.Expense {
    func setup(with model: ExpensesTest.Expense, category: Storage.Category) -> Storage.Expense {
        self.id = model.id
        self.category = category.setup(with: model.category)
        self.date = model.date
        self.subject = model.subject
        self.amount = NSDecimalNumber(floatLiteral: model.amount)
        self.currencyCode = model.currencyCode.rawValue
        self.subject = model.subject
        return self
    }
}
