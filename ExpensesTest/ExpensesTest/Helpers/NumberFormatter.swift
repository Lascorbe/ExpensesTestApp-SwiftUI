//
//  Created by Luis Ascorbe on 08/05/2020.
//  Copyright © 2020 Luis Ascorbe. All rights reserved.
//

import Foundation

let amountFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.isLenient = true
    formatter.numberStyle = .decimal
    return formatter
}()
