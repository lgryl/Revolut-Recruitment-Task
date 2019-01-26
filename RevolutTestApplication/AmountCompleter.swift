//
//  AmountCompleter.swift
//  RevolutTestApplication
//
//  Created by lg on 26/01/2019.
//  Copyright © 2019 lg. All rights reserved.
//

import Foundation

class AmountCompleter {
    
    static let digitPattern = "^\\d*$"
    static let separatorPattern = "^\\d*\(AmountValidator.escapedDecimalSeparator)$"
    static let separatorAndDigitPattern = "^\\d*\(AmountValidator.escapedDecimalSeparator)\\d$"
    
    let digitRegularExpression: NSRegularExpression?
    let separatorRegularExpression: NSRegularExpression?
    let separatorAndDigitRegularExpression: NSRegularExpression?
    
    init() {
        digitRegularExpression = try? NSRegularExpression(pattern: AmountCompleter.digitPattern, options: [])
        separatorRegularExpression = try? NSRegularExpression(pattern: AmountCompleter.separatorPattern, options: [])
        separatorAndDigitRegularExpression = try? NSRegularExpression(pattern: AmountCompleter.separatorAndDigitPattern, options: [])
    }
    
    func complete(_ amount: String?) -> String? {
        guard let amount = amount else {
            return nil
        }
        let range = NSRange(location: 0, length: amount.count)

        if amount.count == 0 {
            return "0" + AmountValidator.decimalSeparator + "00"
        }
        if separatorAndDigitRegularExpression?.numberOfMatches(in: amount, options: [], range: range) == 1 {
            return amount + "0"
        }
        if separatorRegularExpression?.numberOfMatches(in: amount, options: [], range: range) == 1 {
            return amount + "00"
        }
        if digitRegularExpression?.numberOfMatches(in: amount, options: [], range: range) == 1 {
            return amount + AmountValidator.decimalSeparator + "00"
        }
        
        
        return amount
    }
    
}
