//
//  TransactionsCoordinator.swift
//  ExpensesTest
//
//  Created by Luis Ascorbe on 07/05/2020.
//  Copyright © 2020 Luis Ascorbe. All rights reserved.
//

import SwiftUI

protocol TransactionsCoordinator: Coordinator {}

extension TransactionsCoordinator {
    func presentAddExpense(isPresented: Binding<Bool>) -> some View {
        let coordinator = ModalAddExpenseCoordinator(isPresented: isPresented)
        return coordinate(to: coordinator)
    }
}

struct NavigationTransactionsCoordinator: TransactionsCoordinator {
    func start() -> some View {
        let view = TransactionsFactory.make(coordinator: self)
        let navigation = NavigationView { view }
        return navigation
    }
}
