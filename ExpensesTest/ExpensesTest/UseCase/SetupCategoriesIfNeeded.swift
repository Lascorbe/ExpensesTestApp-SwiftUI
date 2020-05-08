//
//  SetupStorage.swift
//  ExpensesTest
//
//  Created by Luis Ascorbe on 08/05/2020.
//  Copyright © 2020 Luis Ascorbe. All rights reserved.
//

import Foundation
import Storage
import CoreData

final class SetupCategoriesIfNeeded: UseCase {
    private let client: CategoryStorageClient
    private let fulfillCategories: () -> Void
    
    
    init(client: CategoryStorageClient = CategoryStorageClient()) {
        self.client = client
        self.fulfillCategories = FulFillCategories(client: client).execute
    }
    
    func execute() {
        client.getCategories { [weak self] categories in
            guard categories.count == 0 else { return }
            self?.fulfillCategories()
        }
    }
}

private final class FulFillCategories: UseCase {
    private let client: CategoryStorageClient
    
    init(client: CategoryStorageClient) {
        self.client = client
    }
    
    func execute() {
        let categories = DefaultCategory.allCases.map { Storage.Category($0, context: client.context) }
        do {
            try client.add(list: categories)
        } catch {
            assertionFailure("Error trying to fill database with categories: \(error.localizedDescription)")
        }
    }
}

private extension Storage.Category {
    convenience init(_ defaultCategory: DefaultCategory, context: NSManagedObjectContext) {
        self.init(context: context)
        self.id = defaultCategory.rawValue
        self.name = defaultCategory.rawValue
        self.color = defaultCategory.color
        self.icon = defaultCategory.icon
    }
}

private enum DefaultCategory: String, CaseIterable {
    case donation
    case food
    case entertainment
    case health
    case electronics
    case shopping
    case transportation
    case utilities
    case other
    
    var color: String {
        switch self {
            case .donation: return "da407a"
            case .food: return "5d11f7"
            case .entertainment: return "941100"
            case .health: return "ec3c1a"
            case .electronics: return "95d26b"
            case .shopping: return "f5b433"
            case .transportation: return "579f2b"
            case .utilities: return "2d7fc1"
            case .other: return "942192"
        }
    }
    
    var icon: String {
        switch self {
            case .donation: return "💟"
            case .food: return "🍣"
            case .entertainment: return "🎭"
            case .health: return "🏥"
            case .electronics: return "📱"
            case .shopping: return "🛒"
            case .transportation: return "🛵"
            case .utilities: return "🔌"
            case .other: return "🃏"
        }
    }
}
