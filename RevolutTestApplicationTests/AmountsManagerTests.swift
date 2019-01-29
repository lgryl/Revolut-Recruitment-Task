//
//  AmountsManagerTests.swift
//  RevolutTestApplicationTests
//
//  Created by lg on 29/01/2019.
//  Copyright © 2019 lg. All rights reserved.
//

import XCTest
@testable import RevolutTestApplication

class AmountsManagerTests: XCTestCase {

    var sut: AmountsManager!
    
    override func setUp() {
        sut = AmountsManager()
    }

    override func tearDown() {
    }

    func test_InitialCount_EqualsOne() {
        let count = sut.amountsCount
        let expectedCount = 1
        
        XCTAssertEqual(expectedCount, count)
    }

    func test_SettingValueForCurrencyThatWasNotAdded_WillNotIncreaseCount() {
        sut.set(3.5, for: "AAA")
        
        let count = sut.amountsCount
        let expectedCount = 1
        
        XCTAssertEqual(expectedCount, count)
    }
    
    func test_AfterAddingCurrencies_CountIncreases() {
        sut.addNewCurrencies(from: ["XXX"])
        
        let count = sut.amountsCount
        let expectedCount = 2
        
        XCTAssertEqual(expectedCount, count)
    }
    
    func test_InitialAmountCurrencyCode_IsEuro() {
        let currencyCode = sut.amount(at: 0).currencyCode
        let expectedCurrencyCode = RatesManager.baseCurrencyCode
        
        XCTAssertEqual(expectedCurrencyCode, currencyCode)
    }
    
    func test_InitialAmountValue_IsZero() {
        let value = sut.amount(at: 0).value
        let expectedValue: Decimal = 0
        
        XCTAssertEqual(expectedValue, value)
    }
    
    func test_AddedAmountInitialValue_IsZero() {
        let currencyCode = "AAA"
        sut.addNewCurrencies(from: [currencyCode])
        
        let amount = sut.amountFor(currencyCode)
        let expectedValue: Decimal = 0
        
        XCTAssertNotNil(amount)
        XCTAssertEqual(expectedValue, amount!.value)
    }
    
    func test_IndexOfNonPresentCurrencyCode_ReturnsNil() {
        let index = sut.index(of: "XYZ")
        
        XCTAssertNil(index)
    }
    
    func test_AfterSettingAmount_ReturnsThatAmount() {
        let currencyCode = RatesManager.baseCurrencyCode
        let value: Decimal = 9.99
        sut.set(value, for: currencyCode)
        
        let returnedAmount = sut.amountFor(currencyCode)
        let expectedValue = value
        
        XCTAssertNotNil(returnedAmount)
        XCTAssertEqual(expectedValue, returnedAmount!.value)
    }
    
    func test_AfterAddingNewCurrency_ItsIndexIsAtTheEnd() {
        let currencyCode = "AAA"
        sut.addNewCurrencies(from: [currencyCode])
        
        let index = sut.index(of: currencyCode)
        let expectedIndex = 1
        
        XCTAssertEqual(expectedIndex, index)
    }
    
    func test_MovingAmount_ChangesItsIndex() {
        let currencyCode = "XYZ"
        sut.addNewCurrencies(from: [currencyCode])
        
        sut.moveAmountFrom(sourceIndex: 1, to: 0)
        
        let index = sut.index(of: currencyCode)
        let expectedIndex = 0
        
        XCTAssertEqual(expectedIndex, index)
    }
    
    func test_AfterSettingValue_UpdateGetsCalled() {
        let amountsManager = AmountsManagerMock()
        amountsManager.set(1.0, for: RatesManager.baseCurrencyCode)
        
        XCTAssertTrue(amountsManager.updateCalled)
    }
    
    func test_SettingValue_UpdatesOtherValues() {
        let ratesManager = FakeRatesManager()
        sut.ratesManager = ratesManager
        let currencyCode = "XXX"
        sut.addNewCurrencies(from: [currencyCode])
        
        XCTAssertEqual(0.0, sut.amountFor(currencyCode)?.value)
        sut.set(5.0, for: RatesManager.baseCurrencyCode)
        XCTAssertEqual(10.0, sut.amountFor(currencyCode)?.value)
    }
    
}

class FakeRatesManager: RatesManager {
    
    override func rate(for currencyCode: String) -> Decimal {
        return 2
    }
    
}

class AmountsManagerMock: AmountsManager {
    var updateCalled = false

    override func update(baseCurrency: String) {
        updateCalled = true
        super.update(baseCurrency: baseCurrency)
    }
}
