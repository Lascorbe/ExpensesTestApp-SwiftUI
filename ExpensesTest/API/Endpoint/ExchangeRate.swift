//
//  ExchangeRate.swift
//  API
//
//  Created by Luis Ascorbe on 07/05/2020.
//  Copyright © 2020 Luis Ascorbe. All rights reserved.
//

import Foundation

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
}
