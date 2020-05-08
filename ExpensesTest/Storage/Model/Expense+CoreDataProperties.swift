//
//  Expense+CoreDataProperties.swift
//  Storage
//
//  Created by Luis Ascorbe on 08/05/2020.
//  Copyright © 2020 Luis Ascorbe. All rights reserved.
//
//

import Foundation
import CoreData


extension Expense {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Expense> {
        return NSFetchRequest<Expense>(entityName: "Expense")
    }

    @NSManaged public var amount: NSDecimalNumber
    @NSManaged public var id: UUID
    @NSManaged public var date: Date
    @NSManaged public var subject: String
    @NSManaged public var currencyCode: String
    @NSManaged public var category: Category

}
