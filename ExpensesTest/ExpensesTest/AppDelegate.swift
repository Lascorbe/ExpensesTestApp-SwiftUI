//
//  AppDelegate.swift
//  ExpensesTest
//
//  Created by Luis Ascorbe on 07/05/2020.
//  Copyright © 2020 Luis Ascorbe. All rights reserved.
//

import UIKit
import Storage

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    private let setupStorage = SetupStorage().execute
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupStorage()
        return true
    }
}
