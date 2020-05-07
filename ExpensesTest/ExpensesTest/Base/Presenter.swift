//
//  File.swift
//  ExpensesTest
//
//  Created by Luis Ascorbe on 07/05/2020.
//  Copyright © 2020 Luis Ascorbe. All rights reserved.
//

import Foundation

class Presenter<C: Coordinator> {
    let coordinator: C?
    
    init(coordinator: C) {
        self.coordinator = coordinator
    }
}
