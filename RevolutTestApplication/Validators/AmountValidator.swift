//
//  AmountValidator.swift
//  RevolutTestApplication
//
//  Created by lg on 26/01/2019.
//  Copyright © 2019 lg. All rights reserved.
//

import Foundation

class AmountValidator {
    
    let localeProvider: LocaleProvider
    
    var regularExpression: NSRegularExpression?
    
    init(localeProvider: LocaleProvider = LocaleProvider()) {
        self.localeProvider = localeProvider
        let pattern = "^((0|([1-9]\\d{0,6}))(\(localeProvider.escapedDecimalSeparator)\\d{0,2})?)?$"
        regularExpression = try? NSRegularExpression(pattern: pattern, options: [])

    }
    
    func isValid(_ amount: String) -> Bool {
        let range = NSRange(location: 0, length: amount.count)
        let fullMatch = regularExpression?.numberOfMatches(in: amount, options: [.anchored], range: range) == 1
        return fullMatch
    }
    
    
}
