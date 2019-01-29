//
//  LocaleProviderTests.swift
//  RevolutTestApplicationTests
//
//  Created by lg on 29/01/2019.
//  Copyright © 2019 lg. All rights reserved.
//

import XCTest
@testable import RevolutTestApplication

class LocaleProviderTests: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
    }
    
    func test_EscapedDecimalSeparator_ForSeparatorWithSpecialMeaningInRegexp_ReturnsEscaped() {
        let localeProvider = FakeLocaleProvider(separator: ".")
        
        let output = localeProvider.escapedDecimalSeparator
        let expectedOutput = "\\."
        
        XCTAssertEqual(expectedOutput, output)
    }

    func test_EscapedDecimalSeparator_ForSeparatorWithoutSpecialMeaningInRegexp_ReturnsNonescaped() {
        let localeProvider = FakeLocaleProvider(separator: ",")
        
        let output = localeProvider.escapedDecimalSeparator
        let expectedOutput = ","
        
        XCTAssertEqual(expectedOutput, output)
    }
    
}
