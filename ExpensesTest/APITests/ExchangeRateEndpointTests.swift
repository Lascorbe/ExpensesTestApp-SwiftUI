//
//  APITests.swift
//  APITests
//
//  Created by Luis Ascorbe on 07/05/2020.
//  Copyright © 2020 Luis Ascorbe. All rights reserved.
//

import XCTest
@testable import API

class ExchangeRateEndpointTests: XCTestCase {
    var endpoint: ExchangeRate!

    override func setUpWithError() throws {
        endpoint = ExchangeRate(currencies: ["USD", "EUR"])
    }

    override func tearDownWithError() throws {
        endpoint = nil
    }

    func testPathIsCorrect() throws {
        XCTAssertTrue(endpoint.path == "live", "Path is not correct")
    }
    
    func testMethodIsCorrect() throws {
        XCTAssertTrue(endpoint.method == .get, "Method is not correct")
    }
    
    func testParametersAreCorrect() throws {
        XCTAssertTrue(endpoint.parameters! == ["currencies": "USD,EUR"], "Parameters are not correct")
    }
}
