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
    private let appLaunch = AppLaunch().execute
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        appLaunch()
        return true
    }
}
