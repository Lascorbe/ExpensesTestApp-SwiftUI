//
//  UpdateCurrencies.swift
//  ExpensesTest
//
//  Created by Luis Ascorbe on 09/05/2020.
//  Copyright © 2020 Luis Ascorbe. All rights reserved.
//

import Foundation

final class AppLaunch: UseCase {
    private let setupStorage = SetupStorage().execute
    private let updateCurrencies = UpdateCurrencies().execute
    
    func execute() {
        setupStorage()
        updateCurrencies()
    }
}
