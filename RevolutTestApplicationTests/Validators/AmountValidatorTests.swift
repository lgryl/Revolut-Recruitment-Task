//
//  AmountValidatorTests.swift
//  RevolutTestApplicationTests
//
//  Created by lg on 28/01/2019.
//  Copyright © 2019 lg. All rights reserved.
//

import XCTest
@testable import RevolutTestApplication

class AmountValidatorTests: XCTestCase {
    
    var sut: AmountValidator!
    
    override func setUp() {
        let localeProvider = FakeLocaleProvider(separator: ".")
        sut = AmountValidator(localeProvider: localeProvider)
    }
    
    override func tearDown() {
    }
    
    func test_EmptyInput_IsValid() {
        assertValid(amount: "", line: #line)
    }
    
    func test_Zero_IsValid() {
        assertValid(amount: "0", line: #line)
    }
    
    func test_AllZerosWithSeparatorAmount_IsValid() {
        assertValid(amount: "0.00", line: #line)
    }
    
    func test_AmountWithoutCents_IsValid() {
        assertValid(amount: "123", line: #line)
    }
    
    func test_AmountWithDecimalPartAndSeparator_IsValid() {
        assertValid(amount: "10.", line: #line)
    }
    
    func test_AmountWithIncompleteCents_IsValid() {
        assertValid(amount: "12.3", line: #line)
    }
    
    func test_FullAmount_IsValid() {
        assertValid(amount: "99.99", line: #line)
    }
    
    func test_NonZeroAmountWithLeadingZero_IsInvalid() {
        assertInvalid(amount: "01", line: #line)
    }
    
    func test_NonZeroAmountWithLeadingZeroAndSeparator_IsInvalid() {
        assertInvalid(amount: "05.", line: #line)
    }
    
    func test_NonZeroAmountWithLeadingZeroSeparatorAndCents_IsInvalid() {
        assertInvalid(amount: "09.99", line: #line)
    }
    
    func test_TwoZerosAmount_IsInvalid() {
        assertInvalid(amount: "00", line: #line)
    }
    
    func test_AmountWithMoreThanTwoDecimalDigits_IsInvalid() {
        assertInvalid(amount: "400.350", line: #line)
    }
    
    func test_NegativeAmount_IsInvalid() {
        assertInvalid(amount: "-100", line: #line)
    }
    
    func test_AmountWithTwoSeparators_IsInvalid() {
        assertInvalid(amount: "100.000.000", line: #line)
    }
    
    func test_AmountWithLeadingSeparator_IsInvalid() {
        assertInvalid(amount: ".99", line: #line)
    }
    
    func test_InputConsistingOfCharactersOtherThanDigitsAndSeparator_IsInvalid() {
        assertInvalid(amount: "zero", line: #line)
    }
    
    func test_AmountWithSeparatorDifferentFromTheLocaleSeparator_IsInvalid() {
        let localeProvider = FakeLocaleProvider(separator: ",")
        let validator = AmountValidator(localeProvider: localeProvider)
        
        let amount = "99.99"
        let valid = validator.isValid(amount)
        
        XCTAssertFalse(valid)
    }
    
    private func assertValid(amount: String, line: UInt) {
        let valid = sut.isValid(amount)
        XCTAssertTrue(valid, line: line)
    }
    
    private func assertInvalid(amount: String, line: UInt) {
        let valid = sut.isValid(amount)
        XCTAssertFalse(valid, line: line)
    }
}
