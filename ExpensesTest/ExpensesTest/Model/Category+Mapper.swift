//
//  Category.swift
//  ExpensesTest
//
//  Created by Luis Ascorbe on 08/05/2020.
//  Copyright © 2020 Luis Ascorbe. All rights reserved.
//

import Storage

extension ExpensesTest.Category {
    init(_ storageCategory: Storage.Category) {
        self.id = storageCategory.id
        self.name = storageCategory.name
        self.hexColor = storageCategory.color
        self.icon = storageCategory.icon
    }
}

extension Storage.Category {
    func setup(with category: ExpensesTest.Category) -> Storage.Category {
        self.id = category.id
        self.name = category.name
        self.color = category.hexColor
        self.icon = category.icon
        return self
    }
}
