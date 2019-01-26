//
//  RatesManager.swift
//  RevolutTestApplication
//
//  Created by lg on 26/01/2019.
//  Copyright © 2019 lg. All rights reserved.
//

import Foundation

class RatesManager {
    let rates: [String: Decimal] = [
        "AUD": 1.6111,
        "BGN": 1.9494,
        "BRL": 4.776,
        "CAD": 1.5288,
        "CHF": 1.1238,
        "CNY": 7.919,
        "CZK": 25.63,
        "DKK": 7.4322,
        "GBP": 0.89528,
        "HKD": 9.1024,
        "HRK": 7.4096,
        "HUF": 325.42,
        "IDR": 17267.0,
        "ILS": 4.1569,
        "INR": 83.442,
        "ISK": 127.38,
        "JPY": 129.12,
        "KRW": 1300.5,
        "MXN": 22.292,
        "MYR": 4.7962,
        "NOK": 9.7438,
        "NZD": 1.7575,
        "PHP": 62.386,
        "PLN": 4.3041,
        "RON": 4.6232,
        "RUB": 79.313,
        "SEK": 10.556,
        "SGD": 1.5947,
        "THB": 38.005,
        "TRY": 7.6031,
        "USD": 1.1596,
        "ZAR": 17.765
    ]
    
    public func rate(for currencyCode: String) -> Decimal? {
        return rates[currencyCode]
    }
}

