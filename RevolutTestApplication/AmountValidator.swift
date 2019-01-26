//
//  AmountValidator.swift
//  RevolutTestApplication
//
//  Created by lg on 26/01/2019.
//  Copyright © 2019 lg. All rights reserved.
//

import Foundation

class AmountValidator {
    
    static var decimalSeparator: String {
        let separator = Locale.current.decimalSeparator ?? "."
        return separator
    }
    
    static var escapedDecimalSeparator: String {
        var separator = AmountValidator.decimalSeparator
        if separator == "." {
            separator = "\\."
        }
        return separator
    }
    
    static let pattern = "^((0|([1-9]\\d{0,6}))(\(AmountValidator.escapedDecimalSeparator)\\d{0,2})?)?$"
    let regularExpression: NSRegularExpression?
    
    init() {
        regularExpression = try? NSRegularExpression(pattern: AmountValidator.pattern, options: [])
    }
    
    func isValid(_ amount: String) -> Bool {
        let range = NSRange(location: 0, length: amount.count)
        let fullMatch = regularExpression?.numberOfMatches(in: amount, options: [.anchored], range: range) == 1
        return fullMatch
    }
    
}
