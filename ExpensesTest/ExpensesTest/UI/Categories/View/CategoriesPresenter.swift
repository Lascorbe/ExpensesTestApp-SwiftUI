//
//  CategoriesPresenter.swift
//  ExpensesTest
//
//  Created by Luis Ascorbe on 07/05/2020.
//  Copyright © 2020 Luis Ascorbe. All rights reserved.
//

import Foundation

protocol CategoriesPresenting: ObservableObject {
    var viewModel: CategoriesViewModel { get }
    func onAppear()
    func add()
}

final class CategoriesPresenter<C: CategoriesCoordinator>: Presenter<C>, CategoriesPresenting {
    @Published private(set) var viewModel: CategoriesViewModel
    
    private let getCategories = GetCategories().execute
    private let saveCategory = SaveCategory().execute
    
    init(viewModel: CategoriesViewModel, coordinator: C) {
        self.viewModel = viewModel
        super.init(coordinator: coordinator)
    }
    
    func onAppear() {
        getCategories { [weak self] categories in
            self?.viewModel = CategoriesViewModel(categories)
        }
    }
    
    func add() {
        let id = viewModel.categories.count + 1
        let category = CategoryViewModel(id: "\(id)", name: "Category \(id)", hexColor: "#2d2d2d", icon: "📱")
        saveCategory(Category(category))
        onAppear()
    }
}
