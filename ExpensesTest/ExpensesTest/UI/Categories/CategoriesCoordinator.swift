//
//  CategoriesCoordinator.swift
//  ExpensesTest
//
//  Created by Luis Ascorbe on 07/05/2020.
//  Copyright © 2020 Luis Ascorbe. All rights reserved.
//

import SwiftUI

protocol CategoriesCoordinator: Coordinator {}

struct NavigationCategoriesCoordinator: CategoriesCoordinator {
    func start() -> some View {
        let view = CategoriesFactory.make(coordinator: self)
        let navigation = NavigationView { view }
        return navigation
    }
}
