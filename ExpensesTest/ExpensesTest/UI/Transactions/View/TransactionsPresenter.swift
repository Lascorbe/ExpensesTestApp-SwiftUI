//
//  TransactionsPresenter.swift
//  ExpensesTest
//
//  Created by Luis Ascorbe on 07/05/2020.
//  Copyright © 2020 Luis Ascorbe. All rights reserved.
//

import SwiftUI

protocol TransactionsPresenting: ObservableObject {
    associatedtype U: View
    var viewModel: TransactionsViewModel { get }
    func onAppear()
    func add(isPresented: Binding<Bool>) -> U
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
    
    func add(isPresented: Binding<Bool>) -> some View {
        return coordinator?.presentAddExpense(isPresented: isPresented)
    }
    
    func remove(at index: Int) {
        guard viewModel.transactions.count > index else { return }
        let expense = viewModel.transactions[index]
        removeExpense(expense.id)
        onAppear()
    }
}
