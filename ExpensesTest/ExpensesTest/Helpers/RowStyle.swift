//
//  View+Navigation.swift
//  ExpensesTest
//
//  Created by Luis Ascorbe on 08/05/2020.
//  Copyright © 2020 Luis Ascorbe. All rights reserved.
//

import SwiftUI

struct ProductFamilyRowStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .colorMultiply(configuration.isPressed ?
                Color.white.opacity(0.5) : Color.white)
    }
}
