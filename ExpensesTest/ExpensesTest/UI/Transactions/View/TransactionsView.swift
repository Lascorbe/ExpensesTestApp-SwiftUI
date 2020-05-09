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
            .onAppear {
                self.presenter.onAppear()
            }
    }
}

private struct Content<T: TransactionsPresenting>: View {
    @ObservedObject var presenter: T
    
    var body: some View {
        Group {
            if presenter.viewModel.transactions.count == 0 {
                Text("You can add a expense from the + button above.")
                    .multilineTextAlignment(.center)
                    .font(.headline)
                    .padding(.horizontal)
            } else {
                List {
                    ForEach(presenter.viewModel.transactions, id: \.self) { transaction in
                        Row(transaction: transaction)
                    }.onDelete { indices in
                        indices.forEach { self.presenter.remove(at: $0) }
                    }
                }
            }
        }
    }
}

private struct Row: View {
    var transaction: TransactionViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text(transaction.category.icon)
                VStack(alignment: .leading) {
                    Text(transaction.dateString)
                        .fontWeight(.light)
                        .font(.system(size: 12))
                    Text(transaction.subject)
                        .fontWeight(.heavy)
                        .foregroundColor(transaction.category.color)
                }
                VStack(alignment: .trailing) {
                    HStack() {
                        Spacer()
                        Text("\(transaction.amount)")
                            .fontWeight(.bold)
                    }
                    if transaction.exchangeRate != nil {
                        HStack {
                            Spacer()
                            VStack(alignment: .trailing) {
                                Text("\(transaction.exchangeRate!.amount)")
                                    .font(.system(size: 13))
                                Text("Last update: \(transaction.exchangeRate!.dateString)")
                                    .fontWeight(.light)
                                    .font(.system(size: 10))
                            }
                            .padding(.all, 5)
                            .background(Color(white: 0.9))
                            .cornerRadius(10)
                        }
                        .padding(.top, 10)
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .buttonStyle(ProductFamilyRowStyle())
    }
}

#if DEBUG
struct TransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        let view = TransactionsFactory.make(with: TransactionsViewModel(transactions: TransactionViewModel.dummy),
                                            coordinator: NavigationTransactionsCoordinator())
        return NavigationView { view }
    }
}

private extension TransactionViewModel {
    static var dummy: [TransactionViewModel] = {
        let category = CategoryViewModel(id: "catId", name: "Electronics", hexColor: "#2d2d2d", icon: "📱")
        var transactions = [TransactionViewModel]()
        let exchangeRate = TransactionViewModel.ExchangeRate(amount: "NZD 24", dateString: "34 minutes ago")
        transactions.insert(TransactionViewModel(id: UUID(), category: category, date: Date(), subject: "Expense 1", amount: "USD 21.24", exchangeRate: exchangeRate), at: 0)
        transactions.insert(TransactionViewModel(id: UUID(), category: category, date: Date(), subject: "Expense 2", amount: "NZD 1983"), at: 0)
        transactions.insert(TransactionViewModel(id: UUID(), category: category, date: Date(), subject: "Expense 3", amount: "NZD 20.19"), at: 0)
        transactions.insert(TransactionViewModel(id: UUID(), category: category, date: Date(), subject: "Expense 4", amount: "NZD 42.05"), at: 0)
        let category2 = CategoryViewModel(id: "catId", name: "Food", hexColor: "#cf6254", icon: "🍣")
        transactions.insert(TransactionViewModel(id: UUID(), category: category2, date: Date(), subject: "Expense 5", amount: "USD 22", exchangeRate: exchangeRate), at: 0)
        return transactions
    }()
    
    init(id: ExpenseId,
         category: CategoryViewModel,
         date: Date,
         subject: String,
         amount: String,
         exchangeRate: ExchangeRate? = nil) {
        self.id = id
        self.category = category
        self.date = date
        self.dateString = dateFormatter.string(from: date)
        self.subject = subject
        self.amount = amount
        self.exchangeRate = exchangeRate
    }
}
#endif
