//
//  Environment.swift
//  ExpensesTest
//
//  Created by Luis Ascorbe on 07/05/2020.
//  Copyright © 2020 Luis Ascorbe. All rights reserved.
//

import Foundation
import API

#if DEBUG
let generalEnvironment: Environment = .dev
#else
let generalEnvironment: Environment = .pro
#endif
