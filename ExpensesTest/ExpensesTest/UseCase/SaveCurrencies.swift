//
//  SaveCurrencies.swift
//  ExpensesTest
//
//  Created by Luis Ascorbe on 09/05/2020.
//  Copyright © 2020 Luis Ascorbe. All rights reserved.
//

import Foundation
import Storage

final class SaveCurrencies: UseCase {
    private let client: CurrencyStorageClient
    
    init(client: CurrencyStorageClient = CurrencyStorageClient()) {
        self.client = client
    }
    
    func execute(currencies: Currencies) {
        let currencyCodes = currencies.list.map { client.makeModel().setup(with: $1, date: currencies.lastUpdate) }
        do {
            try client.add(list: currencyCodes)
            print("Currencies saved: \(currencyCodes)")
        } catch {
            assertionFailure("Error trying to fill database with currencies: \(error.localizedDescription)")
        }
    }
}

private extension Storage.CurrencyCode {
    func setup(with currency: Currency, date: Date) -> Storage.CurrencyCode {
        self.date = date
        self.code = currency.code.rawValue
        self.rateValue = NSDecimalNumber(floatLiteral: currency.value)
        return self
    }
}
