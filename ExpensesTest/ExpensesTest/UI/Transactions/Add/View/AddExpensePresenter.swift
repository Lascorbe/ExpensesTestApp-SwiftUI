//
//  AddExpensePresenter.swift
//  ExpensesTest
//
//  Created by Luis Ascorbe on 10/05/2020.
//  Copyright © 2020 Luis Ascorbe. All rights reserved.
//

import SwiftUI

protocol AddExpensePresenting: ObservableObject {
    var viewModel: AddExpenseViewModel { get }
    func onAppear()
    func onCancel(presentationMode: Binding<PresentationMode>)
    func onSave(presentationMode: Binding<PresentationMode>, formViewModel: FormAddExpenseViewModel)
}

final class AddExpensePresenter<C: AddExpenseCoordinator>: Presenter<C>, AddExpensePresenting {
    @Published private(set) var viewModel: AddExpenseViewModel
    
    private let getCategories = GetCategories().execute
    private let saveExpense = SaveExpense().execute
    
    override init(coordinator: C) {
        self.viewModel = AddExpenseViewModel()
        super.init(coordinator: coordinator)
        self.viewModel.currencyCodes = CurrencyCode.allCases.map { $0.rawValue }
    }
    
    func onAppear() {
        getCategories { [weak self] categories in
            self?.viewModel.categories = categories.map { CategoryViewModel($0) }
        }
    }
    
    func onCancel(presentationMode: Binding<PresentationMode>) {
        presentationMode.wrappedValue.dismiss()
    }
    
    func onSave(presentationMode: Binding<PresentationMode>, formViewModel: FormAddExpenseViewModel) {
        let category = Category(formViewModel.category)
        let currencyCode = CurrencyCode(rawValue: formViewModel.currencyCode)!
        let model = Expense(id: UUID(), category: category, date: formViewModel.date, subject: formViewModel.subject, amount: formViewModel.amount, currencyCode: currencyCode)
        saveExpense(model)
        // onAppear doesn't get fired when coming back from a modal, so we have to notify it
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "didAddExpense"), object: nil)
        presentationMode.wrappedValue.dismiss()
    }
}
