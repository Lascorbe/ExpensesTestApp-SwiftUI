//
//  CurrencyCode+CoreDataProperties.swift
//  Storage
//
//  Created by Luis Ascorbe on 08/05/2020.
//  Copyright © 2020 Luis Ascorbe. All rights reserved.
//
//

import Foundation
import CoreData


extension CurrencyCode {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CurrencyCode> {
        return NSFetchRequest<CurrencyCode>(entityName: "CurrencyCode")
    }

    @NSManaged public var code: String
    @NSManaged public var rateValue: NSDecimalNumber

}
