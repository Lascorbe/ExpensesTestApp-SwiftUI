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
    var groupBy: TransactionsViewModel.GroupBy { get set }
    func onAppear()
    func changeGroupBy(_ groupBy: TransactionsViewModel.GroupBy)
    func add(isPresented: Binding<Bool>) -> U
    func remove(at index: Int, in group: TransactionsViewModel.Group)
}

final class TransactionsPresenter<C: TransactionsCoordinator>: Presenter<C>, TransactionsPresenting {
    @Published private(set) var viewModel: TransactionsViewModel
    
    @Published var groupBy: TransactionsViewModel.GroupBy = .day {
        didSet {
            changeGroupBy(groupBy)
        }
    }
    
    private let getExpenses = GetExpenses().execute
    private let saveExpense = SaveExpense().execute
    private let removeExpense = RemoveExpense().execute
    
    init(viewModel: TransactionsViewModel, coordinator: C) {
        self.viewModel = viewModel
        super.init(coordinator: coordinator)
        NotificationCenter.default.addObserver(self, selector: #selector(onAppear), name: NSNotification.Name(rawValue: "didAddExpense"), object: nil)
    }
    
    @objc func onAppear() {
        getExpenses { [weak self] expenses in
            self?.viewModel = TransactionsViewModel(expenses)
        }
    }
    
    func changeGroupBy(_ groupBy: TransactionsViewModel.GroupBy) {
        viewModel.groupBy = groupBy
    }
    
    func add(isPresented: Binding<Bool>) -> some View {
        return coordinator?.presentAddExpense(isPresented: isPresented)
    }
    
    func remove(at index: Int, in group: TransactionsViewModel.Group) {
        guard group.transactions.count > index else { return }
        let expense = group.transactions[index]
        removeExpense(expense.id)
        onAppear()
    }
}
