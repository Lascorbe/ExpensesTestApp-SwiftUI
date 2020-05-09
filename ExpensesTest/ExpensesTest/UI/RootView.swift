//
//  RootView.swift
//  ExpensesTest
//
//  Created by Luis Ascorbe on 07/05/2020.
//  Copyright © 2020 Luis Ascorbe. All rights reserved.
//

import SwiftUI

struct RootView: View {
    @State private var selection = 0
    
    let transactions = NavigationTransactionsCoordinator()
    let categories = NavigationCategoriesCoordinator()
    
    var body: some View {
        TabView(selection: $selection){
            categories.start()
                .tabItem {
                    VStack {
                        Image(systemName: "chart.pie")
                        Text("Categories")
                    }
            }
            .tag(0)
            transactions.start()
                .tabItem {
                    VStack {
                        Image(systemName: "archivebox")
                        Text("Transactions")
                    }
            }
            .tag(1)
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
