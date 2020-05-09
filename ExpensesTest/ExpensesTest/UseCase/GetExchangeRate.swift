//
//  GetExpenses.swift
//  ExpensesTest
//
//  Created by Luis Ascorbe on 09/05/2020.
//  Copyright © 2020 Luis Ascorbe. All rights reserved.
//

import Foundation
import Storage

final class GetExchangeRate: UseCase {
    func execute(for currencyCode: CurrencyCode, from amount: Double, with currencies: Currencies) -> Expense.ExchangeRate? {
        guard let currency = currencies.list[currencyCode] else { return nil }
        let conversion = amount * currency.value
        return Expense.ExchangeRate(amount: conversion,
                                    currencyCode: currencyCode,
                                    date: currencies.lastUpdate)
    }
}
