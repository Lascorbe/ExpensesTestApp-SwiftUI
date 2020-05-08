//
//  CategoriesCoordinator.swift
//  ExpensesTest
//
//  Created by Luis Ascorbe on 07/05/2020.
//  Copyright © 2020 Luis Ascorbe. All rights reserved.
//

import SwiftUI

enum CategoriesFactory {
    static func make<T: CategoriesCoordinator>(with viewModel: CategoriesViewModel = CategoriesViewModel(categories: []), coordinator: T) -> some View {
        let presenter = CategoriesPresenter(viewModel: viewModel,
                                              coordinator: coordinator)
        let view = CategoriesView(presenter: presenter)
        return view
    }
}
