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
    let hexColor: String
    let color: Color
    let icon: String
    
    init(id: CategoryId, name: String, hexColor: String, icon: String) {
        self.id = id
        self.name = name
        self.hexColor = hexColor
        self.color = Color(hex: hexColor)
        self.icon = icon
    }
}

// MARK: Mappers

extension CategoriesViewModel {
    init(_ categories: [Category]) {
        self.categories = categories.map { CategoryViewModel($0) }
    }
}

extension CategoryViewModel {
    init(_ category: Category) {
        self = .init(id: category.id, name: category.name, hexColor: category.hexColor, icon: category.icon)
    }
}

extension Category {
    init(_ categoryViewModel: CategoryViewModel) {
        self.id = categoryViewModel.id
        self.name = categoryViewModel.name
        self.hexColor = categoryViewModel.hexColor
        self.icon = categoryViewModel.icon
    }
}
