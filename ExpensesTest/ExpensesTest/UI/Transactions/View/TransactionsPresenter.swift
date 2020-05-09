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
    private let saveExpense = SaveExpense().execute
    private let removeExpense = RemoveExpense().execute
    
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
        let number = viewModel.transactions.count + 1
        let category = Category(id: "catId", name: "Electronics", hexColor: "#2d2d2d", icon: "📱")
        let model = Expense(id: UUID(), category: category, date: Date(), subject: "Expense \(number)", amount: 20.19, currencyCode: .USD)
        saveExpense(model)
        onAppear()
    }
    
    func remove(at index: Int) {
        guard viewModel.transactions.count > index else { return }
        let expense = viewModel.transactions[index]
        removeExpense(expense.id)
        onAppear()
    }
}
