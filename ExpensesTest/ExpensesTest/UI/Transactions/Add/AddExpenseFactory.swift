//
//  AddExpenseCoordinator.swift
//  ExpensesTest
//
//  Created by Luis Ascorbe on 10/05/2020.
//  Copyright © 2020 Luis Ascorbe. All rights reserved.
//

import SwiftUI

enum AddExpenseFactory {
    static func make<T: AddExpenseCoordinator>(coordinator: T) -> some View {
        let presenter = AddExpensePresenter(coordinator: coordinator)
        let view = AddExpenseView(presenter: presenter)
        return view
    }
}
