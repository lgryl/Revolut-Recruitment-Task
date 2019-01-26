//
//  AmountsManager.swift
//  RevolutTestApplication
//
//  Created by lg on 26/01/2019.
//  Copyright © 2019 lg. All rights reserved.
//

import Foundation

class AmountsManager {
    private var amounts: [Amount] = [
        Amount(currencyCode: "EUR", value: 0.0),
        Amount(currencyCode: "EUR", value: 0.0),
        Amount(currencyCode: "AUD", value: 0.0),
        Amount(currencyCode: "BGN", value: 0.0),
        Amount(currencyCode: "BRL", value: 0.0),
        Amount(currencyCode: "CAD", value: 0.0),
        Amount(currencyCode: "CHF", value: 0.0),
        Amount(currencyCode: "CNY", value: 0.0),
        Amount(currencyCode: "CZK", value: 0.0),
        Amount(currencyCode: "DKK", value: 0.0),
        Amount(currencyCode: "GBP", value: 0.0),
        Amount(currencyCode: "HKD", value: 0.0),
        Amount(currencyCode: "HRK", value: 0.0),
        Amount(currencyCode: "HUF", value: 0.0),
        Amount(currencyCode: "IDR", value: 0.0),
        Amount(currencyCode: "ILS", value: 0.0),
        Amount(currencyCode: "INR", value: 0.0),
        Amount(currencyCode: "ISK", value: 0.0)
    ]
    
    var amountsCount: Int {
        return amounts.count
    }
    
    public func amount(at index: Int) -> Amount {
        return amounts[index]
    }
    
    public func moveAmountFrom(sourceIndex: Int, to destinationIndex: Int) {
        let element = amounts.remove(at: sourceIndex)
        amounts.insert(element, at: destinationIndex)

    }
}

struct Amount {
    let currencyCode: String
    let value: Decimal
}
