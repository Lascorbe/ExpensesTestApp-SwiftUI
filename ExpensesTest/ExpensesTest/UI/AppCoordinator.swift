//
//  AppCoordinator.swift
//  ExpensesTest
//
//  Created by Luis Ascorbe on 07/05/2020.
//  Copyright © 2020 Luis Ascorbe. All rights reserved.
//

import UIKit
import SwiftUI

final class AppCoordinator {
    private weak var window: UIWindow?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let view = RootView()
        let hosting = UIHostingController(rootView: view)
        window?.rootViewController = hosting
        window?.makeKeyAndVisible()
    }
}
