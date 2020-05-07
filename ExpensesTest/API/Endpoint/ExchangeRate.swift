//
//  ExchangeRate.swift
//  API
//
//  Created by Luis Ascorbe on 07/05/2020.
//  Copyright © 2020 Luis Ascorbe. All rights reserved.
//

import Foundation

/*
 This endpoint will return the latest available exchange rates for the currencies specified
 in the currencies parameter, all relative to the source currency, the default is USD (US Dollars).
 */

struct ExchangeRate: Endpoint {
    var path: String {
        return "live"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: Parameters? {
        return ["currencies": currencies.joined(separator: ",")]
    }
    
    let currencies: [String]
    let source: String
    
    init(currencies: [String], source: String?) {
        self.currencies = currencies
        self.source = source ?? "USD"
    }
}
