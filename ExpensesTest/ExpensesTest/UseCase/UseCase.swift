//
//  GetCurrencies.swift
//  ExpensesTest
//
//  Created by Luis Ascorbe on 07/05/2020.
//  Copyright © 2020 Luis Ascorbe. All rights reserved.
//

import Foundation
import API

class UseCase {
    private(set) var apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func cancel() {
        apiClient.cancelOngoingRequest()
    }
}
