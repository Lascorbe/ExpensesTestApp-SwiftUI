//
//  ExpensesTestTests.swift
//  ExpensesTestTests
//
//  Created by Luis Ascorbe on 07/05/2020.
//  Copyright © 2020 Luis Ascorbe. All rights reserved.
//

import XCTest
@testable import ExpensesTest
@testable import Storage

class GetExchangeRateTests: XCTestCase {
    private var sut: GetExchangeRate!
    
    override func setUpWithError() throws {
        sut = GetExchangeRate()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testGetExchangeRateReturnsCorrectAmount() throws {
        let currencyCode = CurrencyCode.NZD
        let amount: Double = 21.21
        let currencies: Currencies = Currencies(lastUpdate: Date(), list: [.NZD: Currency(code: .NZD, value: 2)])
        
        let result = sut.execute(for: currencyCode, from: amount, with: currencies)!
        
        XCTAssertTrue(result.amount == 42.42, "Expected '42.42' but instead it was \(result.amount)")
    }
    
    func testGetExchangeRateReturnsCorrectCurrency() throws {
        let currencyCode = CurrencyCode.NZD
        let amount: Double = 21.21
        let currencies: Currencies = Currencies(lastUpdate: Date(), list: [.NZD: Currency(code: .NZD, value: 2)])
        
        let result = sut.execute(for: currencyCode, from: amount, with: currencies)!
        
        XCTAssertTrue(result.currencyCode == .NZD, "Expected 'NZD' but instead it was \(result.currencyCode)")
    }
    
    func testGetExchangeRateReturnsCorrectDate() throws {
        let date = Date()
        let currencyCode = CurrencyCode.NZD
        let amount: Double = 21.21
        let currencies: Currencies = Currencies(lastUpdate: date, list: [.NZD: Currency(code: .NZD, value: 2)])
        
        let result = sut.execute(for: currencyCode, from: amount, with: currencies)!
        
        XCTAssertTrue(result.date == date, "Expected '\(date)' but instead it was \(result.date)")
    }
}
