//
//  Category.swift
//  ExpensesTest
//
//  Created by Luis Ascorbe on 08/05/2020.
//  Copyright © 2020 Luis Ascorbe. All rights reserved.
//

import Foundation

typealias CategoryId = String

struct Category: Hashable {
    let id: CategoryId
    let name: String
    let hexColor: String
    let icon: String
}
