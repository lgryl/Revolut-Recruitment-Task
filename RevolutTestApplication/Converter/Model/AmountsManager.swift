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
        Amount(currencyCode: RatesManager.baseCurrencyCode, value: 0.0)
    ]
    
    weak var ratesManager: RatesManager?
    
    var amountsCount: Int {
        return amounts.count
    }
    
    public func amount(at index: Int) -> Amount {
        return amounts[index]
    }
    
    public func index(of currencyCode: String) -> Int? {
        for (index, amount) in amounts.enumerated() {
            if currencyCode == amount.currencyCode {
                return index
            }
        }
        return nil
    }
    
    public func amountFor(_ code: String) -> Amount? {
        for amount in amounts {
            if amount.currencyCode == code {
                return amount
            }
        }
        return nil
    }
    
    public func set(_ value: Decimal, for currencyCode: String) {
        for amount in amounts {
            if currencyCode == amount.currencyCode {
                amount.value = value
            }
        }
        update(baseCurrency: currencyCode)
    }
    
    public func update(baseCurrency: String = RatesManager.baseCurrencyCode) {
        guard let ratesManager = ratesManager else {
            return
        }
        for amount in amounts {
            if amount.currencyCode != baseCurrency {
                let rate = ratesManager.rate(from: baseCurrency, to: amount.currencyCode)
                if let baseAmount = amountFor(baseCurrency) {
                    amount.value = baseAmount.value * rate
                }
            }
        }
    }
    
    public func addNewCurrencies(from currencies: [String]) {
        for currency in currencies {
            if amountFor(currency) == nil {
                let amount = Amount(currencyCode: currency, value: 0.0)
                amounts.append(amount)
            }
        }
    }
    
    public func moveAmountFrom(sourceIndex: Int, to destinationIndex: Int) {
        let element = amounts.remove(at: sourceIndex)
        amounts.insert(element, at: destinationIndex)

    }
}

class Amount {
    var currencyCode: String
    var value: Decimal
    
    init(currencyCode: String, value: Decimal) {
        self.currencyCode = currencyCode
        self.value = value
    }
}
