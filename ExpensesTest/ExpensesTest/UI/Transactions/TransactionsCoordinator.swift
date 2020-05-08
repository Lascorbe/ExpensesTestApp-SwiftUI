//
//  TransactionsCoordinator.swift
//  ExpensesTest
//
//  Created by Luis Ascorbe on 07/05/2020.
//  Copyright © 2020 Luis Ascorbe. All rights reserved.
//

import SwiftUI

protocol TransactionsCoordinator: Coordinator {}

struct NavigationTransactionsCoordinator: TransactionsCoordinator {
    @discardableResult
    func start() -> some View {
        let view = TransactionsFactory.make(coordinator: self)
        let navigation = NavigationView { view }
        return navigation
    }
}
