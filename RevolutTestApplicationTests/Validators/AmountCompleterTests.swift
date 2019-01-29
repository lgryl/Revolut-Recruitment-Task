//
//  AmountCompleterTests.swift
//  RevolutTestApplicationTests
//
//  Created by lg on 29/01/2019.
//  Copyright © 2019 lg. All rights reserved.
//

import XCTest
@testable import RevolutTestApplication

class AmountCompleterTests: XCTestCase {

    var sut: AmountCompleter!
    
    override func setUp() {
        let localeProvider = FakeLocaleProvider(separator: ".")
        sut = AmountCompleter(localeProvider: localeProvider)
    }

    override func tearDown() {
    }

    func test_GivenNil_ReturnsNil(){
        let input: String? = nil
        
        let output = sut.complete(input)
        
        XCTAssertNil(output)
    }
    
    func test_EmptyInput_GivesZerosWithSeparator() {
        assertAmount("", isCompletedTo: "0.00", line: #line)
    }

    func test_Zero_GivesZerosWithSeparator() {
        assertAmount("0", isCompletedTo: "0.00", line: #line)
    }
    
    func test_AmountWithOnlyDecimalPart_WillBeSupplementedWithFractionalPart() {
        assertAmount("120", isCompletedTo: "120.00", line: #line)
    }
    
    func test_AmountEndingWithSeparator_WillBeSupplementedWithTwoZeros() {
        assertAmount("100.", isCompletedTo: "100.00", line: #line)
    }
    
    func test_AmountWithIncompleteFractionalPart_WillBeSupplementedWithTrailingZero() {
        assertAmount("5.1", isCompletedTo: "5.10", line: #line)
    }
    
    func test_ForAmountWithSeparatorDifferentThanLocaleSeparator_WillNotSuplement() {
        assertAmountIsNotCompleted("100,", line: #line)
    }
    
    func test_CompleteAmount_WillNotBeCompleted() {
        assertAmountIsNotCompleted("5001.25", line: #line)
    }
    
    func test_NegativeAmount_WillNotBeCompleted() {
        assertAmountIsNotCompleted("-200", line: #line)
    }
    
    func test_InputWithInvalidCharacters_WillNotBeCompleted() {
        assertAmountIsNotCompleted("300$", line: #line)
    }
    
    private func assertAmount(_ amount: String, isCompletedTo expectedAmount: String, line: UInt) {
        let output = sut.complete(amount)
        XCTAssertEqual(expectedAmount, output)
    }
    
    private func assertAmountIsNotCompleted(_ amount: String, line: UInt) {
        let output = sut.complete(amount)
        
        XCTAssertEqual(amount, output)
    }
    
}
