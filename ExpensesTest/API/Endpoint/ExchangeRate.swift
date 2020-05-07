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

public struct ExchangeRate: Endpoint {
    public var path: String {
        return "live"
    }
    
    public var method: HTTPMethod {
        return .get
    }
    
    public var parameters: Parameters? {
        return ["currencies": currencies.joined(separator: ",")]
    }
    
    public let currencies: [String]
    public let source: String
    
    public init(currencies: [String], source: String = "USD") {
        self.currencies = currencies
        self.source = source
    }
}
