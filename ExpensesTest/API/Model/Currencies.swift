//
//  Currencies.swift
//  API
//
//  Created by Luis Ascorbe on 07/05/2020.
//  Copyright © 2020 Luis Ascorbe. All rights reserved.
//

import Foundation

struct Currencies: Decodable {
    let timestamp: Int
    let quotes: [String: Double]
}