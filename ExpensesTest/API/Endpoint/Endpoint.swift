//
//  Endpoint.swift
//  API
//
//  Created by Luis Ascorbe on 07/05/2020.
//  Copyright © 2020 Luis Ascorbe. All rights reserved.
//

import Foundation

public typealias Path = String
public typealias Parameters = [String: String]

public enum HTTPMethod: String {
    case get, post, put, patch, delete
    
    var string: String {
        return rawValue.uppercased()
    }
}

public protocol Endpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: Parameters? { get }
}

public enum Request {
    case exchangeRate(currencies: [String], source: String?)
}

public extension Request {
    var endpoint: Endpoint {
        switch self {
            case .exchangeRate(let currencies, let source):
                return ExchangeRate(currencies: currencies, source: source)
        }
    }
}
