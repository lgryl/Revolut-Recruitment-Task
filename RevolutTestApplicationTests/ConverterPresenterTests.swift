//
//  ConverterPresenterTests.swift
//  RevolutTestApplicationTests
//
//  Created by lg on 29/01/2019.
//  Copyright © 2019 lg. All rights reserved.
//

import XCTest
@testable import RevolutTestApplication

class ConverterPresenterTests: XCTestCase {

    var dataProvider = ConverterDataProvider()
    var ratesManager = RatesManager()
    var amountsManager = AmountsManager()
    
    override func setUp() {
    }

    override func tearDown() {
    }

    func test_Init_GivenDataProvider_SetsDataProvider() {
        let presenter = ConverterPresenter(dataProvider: dataProvider, ratesManager: ratesManager, amountsManager: amountsManager)
        
        XCTAssertEqual(dataProvider, presenter.dataProvider)
    }

    func test_Init_GivenRatesManager_SetsRatesManager() {
        let presenter = ConverterPresenter(dataProvider: dataProvider, ratesManager: ratesManager, amountsManager: amountsManager)
        
        XCTAssertNotNil(presenter.ratesManager)
    }
    
    func test_Init_GivenAmountsManager_SetsAmountsManager() {
        let presenter = ConverterPresenter(dataProvider: dataProvider, ratesManager: ratesManager, amountsManager: amountsManager)
        
        XCTAssertNotNil(presenter.amountsManager)
    }
    
    func test_AfterInit_ScheduleRatesFetchGotCalled() {
        let presenter = ConverterPresenterMock(dataProvider: dataProvider, ratesManager: ratesManager, amountsManager: amountsManager)
        
        XCTAssertTrue(presenter.scheduleRatesFetchCalled)
    }
    
}

class ConverterPresenterMock: ConverterPresenter {
    
    var scheduleRatesFetchCalled = false
    
    override func scheduleRatesFetch() {
        scheduleRatesFetchCalled = true
    }
    
}
