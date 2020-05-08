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
    
    var body: some View {
        TabView(selection: $selection){
            transactions.start()
                .tabItem {
                    VStack {
                        Image("first")
                        Text("First")
                    }
            }
            .tag(0)
            Text("Second View")
                .font(.title)
                .tabItem {
                    VStack {
                        Image("second")
                        Text("Second")
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
