//
//  AddExpenseViewModel.swift
//  ExpensesTest
//
//  Created by Luis Ascorbe on 10/05/2020.
//  Copyright © 2020 Luis Ascorbe. All rights reserved.
//

import SwiftUI

typealias CurrencyCodeViewModel = String

struct AddExpenseViewModel: Hashable {
    var categories: [CategoryViewModel] = []
    var currencyCodes: [CurrencyCodeViewModel] = []
}

struct FormAddExpenseViewModel {
    let category: CategoryViewModel
    let date: Date
    let subject: String
    let amount: Double
    let currencyCode: CurrencyCodeViewModel
}
