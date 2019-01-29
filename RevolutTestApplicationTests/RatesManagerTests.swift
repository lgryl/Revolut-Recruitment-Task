//
//  RatesManagerTests.swift
//  RevolutTestApplicationTests
//
//  Created by lg on 29/01/2019.
//  Copyright © 2019 lg. All rights reserved.
//

import XCTest
@testable import RevolutTestApplication

class RatesManagerTests: XCTestCase {

    var sut: RatesManager!
    
    override func setUp() {
       sut = RatesManager()
    }

    override func tearDown() {
    }

    func test_InitialRatesCount_IsZero() {
        let ratesCount = sut.rates.count
        let expectedRatesCount = 0
        
        XCTAssertEqual(expectedRatesCount, ratesCount)
    }

    func test_UpdatingRatesWithNewRate_IncreasesRatesCount() {
        let rates: [String: Decimal] = ["ABC" : 3]
        sut.update(rates: rates)
        
        let ratesCount = sut.rates.count
        let expectedRatesCount = 1
        
        XCTAssertEqual(expectedRatesCount, ratesCount)
    }
    
    func test_UpdatingRatesWithExistingRate_DoesNotIncreaseRatesCount() {
        let rates: [String: Decimal] = ["ABC" : 3]
        sut.update(rates: rates)
        
        let anotherRates: [String: Decimal] = ["ABC" : 5.5]
        sut.update(rates: anotherRates)
        
        let ratesCount = sut.rates.count
        let expectedRatesCount = 1
        
        XCTAssertEqual(expectedRatesCount, ratesCount)
    }
    
    func test_BaseCurrency_IsEuro() {
        let baseCurrency = RatesManager.baseCurrencyCode
        let expectedBaseCurrency = "EUR"
        
        XCTAssertEqual(expectedBaseCurrency, baseCurrency)
    }

    func test_RateForEuro_IsOne() {
        let rate = sut.rate(for: RatesManager.baseCurrencyCode)
        let expectedRate = Decimal(integerLiteral: 1)
        
        XCTAssertEqual(expectedRate, rate)
    }
    
    func test_RateForUnknownCurrency_IsZero() {
        let rate = sut.rate(for: "XYZ")
        let expectedRate = Decimal(integerLiteral: 0)
        
        XCTAssertEqual(expectedRate, rate)
    }
    
    func test_RateFromEuroToEuro_IsOne() {
        let rate = sut.rate(from: RatesManager.baseCurrencyCode, to: RatesManager.baseCurrencyCode)
        let expectedRate = Decimal(integerLiteral: 1)
        
        XCTAssertEqual(expectedRate, rate)
    }
    
    func test_RateFromGivenCurrencyToTheSameCurrency_IsOne() {
        let currencyCode = "XYZ"
        let rates: [String: Decimal] = [currencyCode : 2]
        
        sut.update(rates: rates)
        let rate = sut.rate(from: currencyCode, to: currencyCode)
        let expectedRate = Decimal(integerLiteral: 1)
        
        XCTAssertEqual(expectedRate, rate)
    }
    
    func test_AfterUpdate_WillReturnGivenRate() {
        let currencyCode = "ZZZ"
        let rate: Decimal = 0.5
        let rates: [String: Decimal] = [currencyCode : rate]
        
        sut.update(rates: rates)
        let calculatedRate = sut.rate(for: currencyCode)
        let expectedRate = rate
        
        XCTAssertEqual(expectedRate, calculatedRate)
    }
    
    func test_RateFromGivenCurrencyToEuro_EqualsInversionOfRateForThatCurrency() {
        let currencyCode = "XYZ"
        let rate: Decimal = 2
        let rates: [String: Decimal] = [currencyCode : rate]
        sut.update(rates: rates)
        
        let calculatedRate = sut.rate(from: currencyCode, to: RatesManager.baseCurrencyCode)
        let expectedRate = Decimal(integerLiteral: 1) / rate
        
        XCTAssertEqual(expectedRate, calculatedRate)
    }
    
}
