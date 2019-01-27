//
//  RatesManager.swift
//  RevolutTestApplication
//
//  Created by lg on 26/01/2019.
//  Copyright © 2019 lg. All rights reserved.
//

import Foundation

class RatesManager {
    
    static let baseCurrencyCode = "EUR"
    
    var rates: [String: Decimal] = [:]
    
    public func rate(for currencyCode: String) -> Decimal {
        guard currencyCode != RatesManager.baseCurrencyCode else {
            return 1
        }
        return rates[currencyCode] ?? 0
    }
    
    public func rate(from sourceCurrency: String, to destinationCurrency: String) -> Decimal {
        let sourceToEuroRate = 1 / rate(for: sourceCurrency)
        let euroToDestinationRate = rate(for: destinationCurrency)
        
        if sourceCurrency == RatesManager.baseCurrencyCode {
            return euroToDestinationRate
        }
        if destinationCurrency == RatesManager.baseCurrencyCode {
            return sourceToEuroRate
        }
        let finalRate = sourceToEuroRate * euroToDestinationRate
        return finalRate
    }
    
    public func update(rates: [String: Decimal]) {
        for (code, rate) in rates {
            self.rates[code] = rate
        }
    }
}

