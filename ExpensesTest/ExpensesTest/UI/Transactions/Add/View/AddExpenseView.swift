//
//  AddExpenseView.swift
//  ExpensesTest
//
//  Created by Luis Ascorbe on 10/05/2020.
//  Copyright © 2020 Luis Ascorbe. All rights reserved.
//

import SwiftUI

struct AddExpenseView<T: AddExpensePresenting>: View {
    @ObservedObject private var presenter: T
    
    init(presenter: T) {
        self.presenter = presenter
    }
    
    var body: some View {
        Content(presenter: presenter)
            .navigationBarTitle(Text("Add Expense"))
            .onAppear {
                self.presenter.onAppear()
            }
    }
}

private struct Content<T: AddExpensePresenting>: View {
    enum ShowError {
        case subject, amount, category
    }
    
    @ObservedObject var presenter: T
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var category: CategoryViewModel?
    @State var date: Date = Date()
    @State var subject: String = ""
    @State var amount: String = "0"
    @State var currencyCode: CurrencyCodeViewModel = CurrencyCode.USD.rawValue
    
    @State var showError: ShowError?
    
    var body: some View {
        VStack {
            if showError != nil {
                ZStack {
                    Color.red
                    if showError == .subject {
                        Text("Please, enter a subject")
                    } else if showError == .amount {
                        Text("Amount must be higher than 0")
                    } else if showError == .category {
                        Text("Please, select a category")
                    }
                }
                .frame(maxHeight: 50)
            }
            Form {
                TextField("Subject", text: $subject)
                    .disableAutocorrection(true)
                
                TextField("Amount", text: $amount)
                    .disableAutocorrection(true)
                    .keyboardType(.numbersAndPunctuation)
                
                Picker(selection: $currencyCode, label: Text("Currency")) {
                    ForEach(presenter.viewModel.currencyCodes, id: \.description) { currencyCode in
                        Text(currencyCode).tag(currencyCode)
                    }
                }
                
                Picker(selection: $category, label: Text("Category")) {
                    ForEach(Category.allCases) { category in
                        Text(category.rawValue.capitalized).tag(category)
                    }
                }
                Picker(selection: $category, label: Text("Category")) {
                    ForEach(presenter.viewModel.categories, id: \.id) { category in
                        HStack {
                            Text(category.icon)
                            Text(category.name)
                                .fontWeight(.heavy)
                                .foregroundColor(category.color)
                            Spacer()
                        }.tag(category)
                    }
                }
                
                DatePicker(selection: $date, displayedComponents: .date) {
                    Text("Date")
                }
            }
        }
        .navigationBarItems(
            leading: Button(
                action: {
                    self.presenter.onCancel(presentationMode: self.presentationMode)
            }
            ) {
                Text("Cancel")
            },
            trailing: Button(
                action: {
                    guard self.subject != ""  else {
                        self.showError = .subject
                        return
                    }
                    guard let amount = Double(self.amount), amount > 0 else {
                        self.showError = .amount
                        return
                    }
                    guard let category = self.category else {
                        self.showError = .category
                        return
                    }
                    self.showError = nil
                    let fields = FormAddExpenseViewModel(category: category, date: self.date, subject: self.subject, amount: amount, currencyCode: self.currencyCode)
                    self.presenter.onSave(presentationMode: self.presentationMode,
                                          formViewModel: fields)
            }
            ) {
                Text("Save")
            }
        )
    }
}

#if DEBUG
struct AddExpenseView_Previews: PreviewProvider {
    @State static var isPresented = false
    
    static var previews: some View {
        let view = AddExpenseFactory.make(coordinator: ModalAddExpenseCoordinator(isPresented: $isPresented))
        return NavigationView { view }
    }
}
#endif
