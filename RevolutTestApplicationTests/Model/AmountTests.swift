//
//  AmountTests.swift
//  RevolutTestApplicationTests
//
//  Created by lg on 29/01/2019.
//  Copyright © 2019 lg. All rights reserved.
//

import XCTest
@testable import RevolutTestApplication

class AmountTests: XCTestCase {
    
    override func setUp() {
    }

    override func tearDown() {
    }

    func test_Init_WhenGivenCurrencyCode_SetsCurrencyCode() {
        let currencyCode = "PLN"
        
        let amount = Amount(currencyCode: currencyCode, value: Decimal(integerLiteral: 0))
        
        XCTAssertEqual(currencyCode, amount.currencyCode, "Should set currency code")
    }

    func test_Init_WhenGivenValue_SetsValue() {
        let value = Decimal(integerLiteral: 100)
        
        let amount = Amount(currencyCode: "", value: value)
        
        XCTAssertEqual(value, amount.value, "Should set value")
    }
    
}
