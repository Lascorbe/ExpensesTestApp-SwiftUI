//
//  ExchangeRate.swift
//  API
//
//  Created by Luis Ascorbe on 07/05/2020.
//  Copyright © 2020 Luis Ascorbe. All rights reserved.
//

import Foundation

public enum Environment {
    case dev
    case pro
    
    var baseUrl: String {
        switch self {
            case .dev:
                return "http://api.currencylayer.com"
            case .pro:
                return "http://api.currencylayer.com" // I'd use https, but the free plan doesn't let me
        }
    }
}
