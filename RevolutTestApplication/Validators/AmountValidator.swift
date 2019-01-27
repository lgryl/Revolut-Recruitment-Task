//
//  AmountValidator.swift
//  RevolutTestApplication
//
//  Created by lg on 26/01/2019.
//  Copyright © 2019 lg. All rights reserved.
//

import Foundation

class AmountValidator {
    
    static var regularExpression: NSRegularExpression? {
        let pattern = "^((0|([1-9]\\d{0,6}))(\(LocaleHelper.escapedDecimalSeparator)\\d{0,2})?)?$"
        let regularExpression = try? NSRegularExpression(pattern: pattern, options: [])
        return regularExpression
    }
    
    func isValid(_ amount: String) -> Bool {
        let range = NSRange(location: 0, length: amount.count)
        let fullMatch = AmountValidator.regularExpression?.numberOfMatches(in: amount, options: [.anchored], range: range) == 1
        return fullMatch
    }
    
}
