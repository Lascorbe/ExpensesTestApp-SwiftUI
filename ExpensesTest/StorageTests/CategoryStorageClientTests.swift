//
//  StorageTests.swift
//  StorageTests
//
//  Created by Luis Ascorbe on 07/05/2020.
//  Copyright © 2020 Luis Ascorbe. All rights reserved.
//

import XCTest
import CoreData
@testable import Storage

class CategoryStorageClientTests: XCTestCase {
    private var mock: MockedCoreDataStack!
    private var client: CategoryStorageClient!
    
    override func setUpWithError() throws {
        mock = MockedCoreDataStack()
        client = CategoryStorageClient(storageClient: StorageClient(coreDataStack: mock))
    }
    
    override func tearDownWithError() throws {
        client = nil
    }
    
    func testCallToAddInsertsInContext() throws {
        let model = Storage.Category()
        try client.add(model)
        XCTAssertTrue(mock.viewContext.insertCalled, "Insert was not called")
    }
    
    func testCallToAddSavesContext() throws {
        let model = Storage.Category()
        try client.add(model)
        XCTAssertTrue(mock.viewContext.saveContextCalled, "SaveContext was not called")
    }
}

private class MockedCoreDataStack: CoreDataStack {
    let mock = MockedNSManagedObjectContext()
    override var viewContext: MockedNSManagedObjectContext {
        return mock
    }
}

private class MockedNSManagedObjectContext: NSManagedObjectContext {
    var insertCalled = false
    var saveContextCalled = false
    
    init() {
        super.init(concurrencyType: .mainQueueConcurrencyType)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func insert(_ object: NSManagedObject) {
        insertCalled = true
    }
    
    override func saveContext() throws {
        saveContextCalled = true
    }
}
