//
//  AddExpenseCoordinator.swift
//  ExpensesTest
//
//  Created by Luis Ascorbe on 10/05/2020.
//  Copyright © 2020 Luis Ascorbe. All rights reserved.
//

import SwiftUI

protocol AddExpenseCoordinator: Coordinator {}

struct NavigationAddExpenseCoordinator: AddExpenseCoordinator {
    @discardableResult
    func start() -> some View {
        let view = AddExpenseFactory.make(coordinator: self)
        let navigation = NavigationView { view }
        return navigation
    }
}
