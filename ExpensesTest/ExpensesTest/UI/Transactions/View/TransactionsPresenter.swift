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
    func onAppear()
    func add()
    func remove(at index: Int)
}

final class TransactionsPresenter<C: TransactionsCoordinator>: Presenter<C>, TransactionsPresenting {
    @Published private(set) var viewModel: TransactionsViewModel
    
    private let getExpenses = GetExpenses().execute
    
    init(viewModel: TransactionsViewModel, coordinator: C) {
        self.viewModel = viewModel
        super.init(coordinator: coordinator)
    }
    
    func onAppear() {
        getExpenses { [weak self] expenses in
            self?.viewModel = TransactionsViewModel(expenses)
        }
    }
    
    func add() {
        let id = viewModel.transactions.count + 1
        let category = CategoryViewModel(id: "catId", name: "Electronics", hexColor: "#2d2d2d", icon: "📱")
        viewModel.transactions.insert(TransactionViewModel(id: UUID(), category: category, date: "09/05/2020", subject: "Expense \(id)", amount: "USD 20.19"),
                            at: 0)
    }
    
    func remove(at index: Int) {
        viewModel.transactions.remove(at: index)
    }
}
