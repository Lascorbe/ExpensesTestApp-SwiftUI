//
//  File.swift
//  ExpensesTest
//
//  Created by Luis Ascorbe on 07/05/2020.
//  Copyright © 2020 Luis Ascorbe. All rights reserved.
//

import Foundation

enum CurrencyCode: String, CaseIterable {
    case USD, NZD
    
    init?(quote: String) {
        switch quote {
            case "USDNZD":
                self = .NZD
            case "USDUSD":
                self = .USD
            default:
                return nil
        }
    }
}
