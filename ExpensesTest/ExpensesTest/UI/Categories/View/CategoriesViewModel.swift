//
//  CategoriesViewModel.swift
//  ExpensesTest
//
//  Created by Luis Ascorbe on 07/05/2020.
//  Copyright © 2020 Luis Ascorbe. All rights reserved.
//

import SwiftUI

struct CategoriesViewModel: Hashable {
    var categories: [CategoryViewModel]
}

struct CategoryViewModel: Hashable {
    let id: CategoryId
    let name: String
    let color: Color
    let icon: String
}

// MARK: Mappers

extension CategoriesViewModel {
    init(_ categories: [Category]) {
        self.categories = categories.map { CategoryViewModel($0) }
    }
}

extension CategoryViewModel {
    init(_ category: Category) {
        self.id = category.id
        self.name = category.name
        self.color = Color(hex: category.hexColor)
        self.icon = category.icon
    }
}
