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
    
    @Environment(\.presentationMode) var presentationMode
    
    init(presenter: T) {
        self.presenter = presenter
    }
    
    var body: some View {
        Content(presenter: presenter)
            .navigationBarTitle(Text("Add Expense"))
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
                        self.presenter.onSave(presentationMode: self.presentationMode)
                    }
                ) {
                    Text("Save")
                }
            )
            .onAppear {
                self.presenter.onAppear()
            }
    }
}

private struct Content<T: AddExpensePresenting>: View {
    @ObservedObject var presenter: T
    
    @State var category: CategoryViewModel?
    @State var date: Date = Date()
    @State var subject: String = ""
    @State var amount: Double = 0
    @State var currencyCode: CurrencyCodeViewModel = CurrencyCode.USD.rawValue
    
    var body: some View {
        Form {
            TextField("Subject", text: $subject)
                .disableAutocorrection(true)
            
            Picker(selection: $currencyCode, label: Text("Currency")) {
                ForEach(presenter.viewModel.currencyCodes, id: \.description) { currencyCode in
                    Text(currencyCode).tag(currencyCode)
                }
            }
            
            TextField("Amount", value: $amount, formatter: amountFormatter)
                .keyboardType(.numbersAndPunctuation)
            
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
}

#if DEBUG
struct AddExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        let view = AddExpenseFactory.make(coordinator: NavigationAddExpenseCoordinator())
        return NavigationView { view }
    }
}
#endif
