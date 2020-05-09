//
//  GetCurrencies.swift
//  ExpensesTest
//
//  Created by Luis Ascorbe on 07/05/2020.
//  Copyright © 2020 Luis Ascorbe. All rights reserved.
//

import Foundation
import Storage

final class GetCurrencies: UseCase {
    private let client: CurrencyStorageClient
    
    init(client: CurrencyStorageClient = CurrencyStorageClient()) {
        self.client = client
    }
    
    func execute(completion: @escaping (Currencies?) -> Void) {
        client.getCurrencies { currencyCodes in
            let currencies = Currencies(currencyCodes: currencyCodes)
            completion(currencies)
        }
    }
}

private extension Currencies {
    init?(currencyCodes: [Storage.CurrencyCode]) {
        guard currencyCodes.count > 0 else { return nil }
        self.lastUpdate = currencyCodes[0].date
        self.list = currencyCodes.reduce(into: [CurrencyCode: Currency]()) {
            let currency = Currency(currencyCode: $1)
            return $0[currency.code] = currency
        }
    }
}

private extension Currency {
    init(currencyCode: Storage.CurrencyCode) {
        self.code = CurrencyCode(rawValue: currencyCode.code)!
        self.value = Double(truncating: currencyCode.rateValue)
    }
}
