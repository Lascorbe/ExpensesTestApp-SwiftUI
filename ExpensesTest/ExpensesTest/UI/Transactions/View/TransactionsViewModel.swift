//
//  TransactionsViewModel.swift
//  ExpensesTest
//
//  Created by Luis Ascorbe on 07/05/2020.
//  Copyright © 2020 Luis Ascorbe. All rights reserved.
//

import Foundation

struct TransactionsViewModel: Hashable {
    enum GroupBy: String, CaseIterable {
        case day, month
        
        fileprivate var dateComponents: Set<Calendar.Component> {
            switch self {
                case .day: return [.year, .month, .day]
                case .month: return [.year, .month]
            }
        }
        
        fileprivate var dateFormatter: DateFormatter {
            switch self {
                case .day: return dayDateFormatter
                case .month: return monthDateFormatter
            }
        }
        
        fileprivate var detailDateFormatter: DateFormatter {
            switch self {
                case .day: return detailDayDateFormatter
                case .month: return detailMonthDateFormatter
            }
        }
    }
    
    struct Group: Hashable {
        let dateString: String
        let transactions: [TransactionViewModel]
    }
    
    var groupBy: GroupBy = .day {
        didSet {
            resetTransactions()
        }
    }
    var transactionsGrouped: [Group] = []
    
    fileprivate var transactions: [Expense] {
        didSet {
            resetTransactions()
        }
    }
}

struct TransactionViewModel: Hashable {
    struct ExchangeRate: Hashable {
        let amount: String
        let dateString: String
    }
    
    let id: ExpenseId
    let category: CategoryViewModel
    let date: Date
    let dateString: String
    let subject: String
    let amount: String
    let exchangeRate: ExchangeRate?
}

// MARK: Mappers

extension TransactionsViewModel {
    init(_ models: [Expense], groupBy: GroupBy = .day) {
        self.groupBy = groupBy
        self.transactions = models
        resetTransactions()
    }
    
    fileprivate mutating func resetTransactions() {
        self.transactionsGrouped = Self.groupedTransactions(by: groupBy, models: transactions)
    }
    
    fileprivate static func groupedTransactions(by groupBy: GroupBy, models: [Expense]) -> [Group] {
        let dateComponents = groupBy.dateComponents
        let sectionDateFormatter = groupBy.dateFormatter
        let rowDateFormatter = groupBy.detailDateFormatter
        let dictionary = models.reduce(into: [Date: [TransactionViewModel]]()) { result, model in
            let components = Calendar.current.dateComponents(dateComponents, from: model.date)
            let date = Calendar.current.date(from: components)!
            let existing = result[date] ?? []
            result[date] = existing + [TransactionViewModel(model, dateFormatter: rowDateFormatter)]
        }
        let sortedKeys = Array(dictionary.keys).sorted { $0 > $1 }
        return sortedKeys.map {
            Group(dateString: sectionDateFormatter.string(from: $0),
                  transactions: dictionary[$0]!)
        }
    }
}

extension TransactionViewModel {
    init(_ model: Expense, dateFormatter: DateFormatter) {
        self.id = model.id
        self.category = CategoryViewModel(model.category)
        self.date = model.date
        self.dateString = dateFormatter.string(from: model.date)
        self.subject = model.subject
        self.amount = String.localizedStringWithFormat("%@ %.2f", model.currencyCode.rawValue, model.amount)
        self.exchangeRate = ExchangeRate(model.exchangeRate)
    }
}

extension TransactionViewModel.ExchangeRate {
    init?(_ model: Expense.ExchangeRate?) {
        guard let model = model else { return nil }
        self.amount = String.localizedStringWithFormat("%@ %.2f", model.currencyCode.rawValue, model.amount)
        self.dateString = relativeDateFormatter.localizedString(for: model.date, relativeTo: Date())
    }
}
