//
//  CategoriesView.swift
//  ExpensesTest
//
//  Created by Luis Ascorbe on 07/05/2020.
//  Copyright © 2020 Luis Ascorbe. All rights reserved.
//

import SwiftUI

struct CategoriesView<T: CategoriesPresenting>: View {
    @ObservedObject private var presenter: T
    
    init(presenter: T) {
        self.presenter = presenter
    }
    
    var body: some View {
        Content(presenter: presenter)
            .navigationBarTitle(Text("Categories"))
            .navigationBarItems(
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

private struct Content<T: CategoriesPresenting>: View {
    @ObservedObject var presenter: T
    
    var body: some View {
        List {
            ForEach(presenter.viewModel.categories, id: \.self) { category in
                Row(category: category)
            }
        }
    }
}

private struct Row: View {
    var category: CategoryViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text(category.icon)
                Text(category.name)
                    .fontWeight(.heavy)
                    .foregroundColor(category.color)
                Spacer()
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .buttonStyle(ProductFamilyRowStyle())
    }
}

#if DEBUG
struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        let view = CategoriesFactory.make(with: CategoriesViewModel(categories: CategoryViewModel.dummy),
                                          coordinator: NavigationCategoriesCoordinator())
        return NavigationView { view }
    }
}

private extension CategoryViewModel {
    static var dummy: [CategoryViewModel] = {
        var categories = [CategoryViewModel]()
        categories.append(CategoryViewModel(id: "1", name: "Electronics", color: .blue, icon: "📱"))
        categories.append(CategoryViewModel(id: "2", name: "Fashion", color: .blue, icon: "👘"))
        categories.append(CategoryViewModel(id: "3", name: "Sports", color: .blue, icon: "🏊‍♂️"))
        categories.append(CategoryViewModel(id: "4", name: "Real Estate", color: .blue, icon: "🏡"))
        categories.append(CategoryViewModel(id: "5", name: "Vehicle", color: .blue, icon: "🛵"))
        return categories
    }()
}
#endif
