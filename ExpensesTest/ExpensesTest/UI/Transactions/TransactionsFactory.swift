//
//  TransactionsCoordinator.swift
//  ExpensesTest
//
//  Created by Luis Ascorbe on 07/05/2020.
//  Copyright © 2020 Luis Ascorbe. All rights reserved.
//

import SwiftUI

enum TransactionsFactory {
    static func make<T: TransactionsCoordinator>(with viewModel: TransactionsViewModel = TransactionsViewModel([]), coordinator: T) -> some View {
        let presenter = TransactionsPresenter(viewModel: viewModel,
                                              coordinator: coordinator)
        let view = TransactionsView(presenter: presenter)
        return view
    }
}
