//
//  TransactionsView.swift
//  ExpensesTest
//
//  Created by Luis Ascorbe on 07/05/2020.
//  Copyright © 2020 Luis Ascorbe. All rights reserved.
//

import SwiftUI

struct TransactionsView<T: TransactionsPresenting>: View {
    @ObservedObject private var presenter: T
    
    init(presenter: T) {
        self.presenter = presenter
    }
    
    var body: some View {
        Content(presenter: presenter)
            .navigationBarTitle(Text("Transactions"))
            .navigationBarItems(
                leading: EditButton(),
                trailing: Button(
                    action: {
                        withAnimation {
                            self.presenter.add()
                        }
                }
                ) {
                    Image(systemName: "plus")
                }
        )
    }
}

private struct Content<T: TransactionsPresenting>: View {
    @ObservedObject var presenter: T
    
    var body: some View {
        List {
            ForEach(presenter.viewModel.transactions, id: \.self) { transaction in
                Row(transaction: transaction)
            }.onDelete { indices in
                indices.forEach { self.presenter.remove(at: $0) }
            }
        }
    }
}

private struct Row: View {
    var transaction: TransactionViewModel
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text(transaction.dateFormatted)
                    .fontWeight(.light)
                    .font(.system(size: 12))
                    .padding(.bottom)
            }
            HStack {
                Text(transaction.category.icon)
                Text(transaction.subject)
                    .fontWeight(.heavy)
                    .foregroundColor(transaction.category.color)
                VStack(alignment: .trailing) {
                    HStack() {
                        Spacer()
                        Text("\(transaction.amountFormatted)")
                            .fontWeight(.bold)
                    }
                    Spacer()
                    if transaction.exchangeRate != nil {
                        VStack(alignment: .trailing) {
                            Text("\(transaction.exchangeRate!.amountFormatted)")
                                .font(.system(size: 12))
                            Text("Last update: \(transaction.exchangeRate!.dateFormatted)")
                                .fontWeight(.light)
                                .font(.system(size: 9))
                        }
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .buttonStyle(ProductFamilyRowStyle())
    }
}

struct TransactionsView_Previews: PreviewProvider {
    private static var transactions: [TransactionViewModel] = {
        let category = CategoryViewModel(id: "catId", name: "Electronics", color: .blue, icon: "📱")
        var transactions = [TransactionViewModel]()
        let exchangeRate = TransactionViewModel.ExchangeRate(amount: 24, currencyCode: "NZD", date: Date())
        transactions.insert(TransactionViewModel(id: "1", category: category, date: Date(), subject: "Expense 1", amount: 20.19, currencyCode: "USD", exchangeRate: exchangeRate), at: 0)
        transactions.insert(TransactionViewModel(id: "2", category: category, date: Date(), subject: "Expense 2", amount: 42.01, currencyCode: "NZD"), at: 0)
        transactions.insert(TransactionViewModel(id: "3", category: category, date: Date(), subject: "Expense 3", amount: 1234, currencyCode: "NZD"), at: 0)
        transactions.insert(TransactionViewModel(id: "4", category: category, date: Date(), subject: "Expense 4", amount: 1983, currencyCode: "NZD"), at: 0)
        transactions.insert(TransactionViewModel(id: "5", category: category, date: Date(), subject: "Expense 5", amount: 20, currencyCode: "USD", exchangeRate: exchangeRate), at: 0)
        return transactions
    }()
    
    static var previews: some View {
        let view = TransactionsFactory.make(with: TransactionsViewModel(transactions: transactions),
                                            coordinator: NavigationTransactionsCoordinator())
        return NavigationView { view }
    }
}
