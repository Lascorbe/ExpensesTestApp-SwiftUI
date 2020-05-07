//
//  GetCurrencies.swift
//  ExpensesTest
//
//  Created by Luis Ascorbe on 07/05/2020.
//  Copyright © 2020 Luis Ascorbe. All rights reserved.
//

import Foundation
import API

final class GetCurrencies: UseCase {
    private var client: ExchangeRateClient { apiClient as! ExchangeRateClient }
    
    init(client: ExchangeRateClient = ExchangeRateClient(engine: Engine(environment: generalEnvironment))) {
        super.init(apiClient: client)
    }
    
    func execute(valuesFor currencies: [CurrencyCode], completion: @escaping (Result<Currencies, Engine.Error>) -> Void) throws {
        let list = currencies.map { $0.rawValue }
        let endpoint = ExchangeRate(currencies: list)
        try client.sendRequest(with: endpoint) { result in
            switch result {
                case .success(let apiCurrencies):
                    let mappedCurrencies = Currencies(apiCurrencies: apiCurrencies)
                    completion(.success(mappedCurrencies))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}

private extension Currencies {
    init(apiCurrencies: API.Currencies) {
        self.lastUpdate = Date()
        var quotes: [CurrencyCode: Currency] = [:]
        for (key, value) in apiCurrencies.quotes {
            if let code = CurrencyCode(rawValue: key) {
                quotes[code] = Currency(code: code, value: value)
            } else {
                preconditionFailure("CurrencyCode '\(key)' is not in the CurrencyCode enum")
            }
        }
        self.list = quotes
    }
}
