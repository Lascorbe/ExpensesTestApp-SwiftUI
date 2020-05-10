//
//  AddExpenseCoordinator.swift
//  ExpensesTest
//
//  Created by Luis Ascorbe on 10/05/2020.
//  Copyright © 2020 Luis Ascorbe. All rights reserved.
//

import SwiftUI

protocol AddExpenseCoordinator: Coordinator {}

struct ModalAddExpenseCoordinator: AddExpenseCoordinator {
    private var isPresented: Binding<Bool>
    
    init(isPresented: Binding<Bool>) {
        self.isPresented = isPresented
    }
    
    func start() -> some View {
        let view = AddExpenseFactory.make(coordinator: self)
        let destination = NavigationView { view }
        return ModalLinkWrapper(destination: destination, isPresented: isPresented)
    }
}
