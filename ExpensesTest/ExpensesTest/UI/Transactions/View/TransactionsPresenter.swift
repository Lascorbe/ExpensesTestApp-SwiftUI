//
//  TransactionsPresenter.swift
//  ExpensesTest
//
//  Created by Luis Ascorbe on 07/05/2020.
//  Copyright © 2020 Luis Ascorbe. All rights reserved.
//

import Foundation

protocol TransactionsPresenting: ObservableObject {
    var viewModel: TransactionsViewModel { get }
    func add()
    func remove(at index: Int)
}

final class TransactionsPresenter<C: TransactionsCoordinator>: Presenter<C>, TransactionsPresenting {
    @Published private(set) var viewModel: TransactionsViewModel
    
    init(viewModel: TransactionsViewModel, coordinator: C) {
        self.viewModel = viewModel
        super.init(coordinator: coordinator)
    }
    
    func add() {
        let id = viewModel.transactions.count + 1
        let category = CategoryViewModel(id: "catId", name: "Electronics", color: .blue, icon: "📱")
        viewModel.transactions.insert(TransactionViewModel(id: "\(id)", category: category, date: Date(), subject: "Expense \(id)", amount: 20.19, currencyCode: "USD"),
                            at: 0)
    }
    
    func remove(at index: Int) {
        viewModel.transactions.remove(at: index)
    }
}
