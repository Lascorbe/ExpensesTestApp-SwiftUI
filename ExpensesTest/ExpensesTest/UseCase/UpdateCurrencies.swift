//
//  UpdateCurrencies.swift
//  ExpensesTest
//
//  Created by Luis Ascorbe on 09/05/2020.
//  Copyright © 2020 Luis Ascorbe. All rights reserved.
//

import Foundation

final class UpdateCurrencies: UseCase {
    private let request = RequestCurrencies().execute
    private let save = SaveCurrencies().execute
    
    func execute() {
        do {
            try request([.USD, .NZD]) { [weak self] result in
                switch result {
                    case .success(let currencies):
                        self?.executeSave(currencies)
                    case .failure(let error):
                        print("Currency request failed: \(error)")
                }
            }
        } catch {
            assertionFailure("Error trying to fill database with currencies: \(error.localizedDescription)")
        }
    }
    
    private func executeSave(_ currencies: Currencies) {
        do {
            try save(currencies)
        } catch {
            assertionFailure("Error trying to fill database with currencies: \(error.localizedDescription)")
        }
    }
}
