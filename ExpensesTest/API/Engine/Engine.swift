//
//  ExchangeRate.swift
//  API
//
//  Created by Luis Ascorbe on 07/05/2020.
//  Copyright © 2020 Luis Ascorbe. All rights reserved.
//

import Foundation

struct Engine {
    indirect enum Error: Swift.Error {
        case requestFailed
        case unknown(Error)
    }
    
    func request(_ request: Request) {
        
    }
}
