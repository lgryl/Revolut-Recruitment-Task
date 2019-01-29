//
//  AmountCompleter.swift
//  RevolutTestApplication
//
//  Created by lg on 26/01/2019.
//  Copyright © 2019 lg. All rights reserved.
//

import Foundation

class AmountCompleter {
    
    let localeProvider: LocaleProvider
    
    let trailingDigitRegularExpression: NSRegularExpression?
    let trailingSeparatorRegularExpression: NSRegularExpression?
    let trailingSeparatorAndDigitRegularExpression: NSRegularExpression?
    
    init(localeProvider: LocaleProvider = LocaleProvider()) {
        self.localeProvider = localeProvider
        
        let trailingDigitPattern = "^\\d*$"
        trailingDigitRegularExpression = try? NSRegularExpression(pattern: trailingDigitPattern, options: [])
        
        let trailingSeparatorPattern = "^\\d*\(localeProvider.escapedDecimalSeparator)$"
        trailingSeparatorRegularExpression = try? NSRegularExpression(pattern: trailingSeparatorPattern, options: [])

        let separatorAndDigitPattern = "^\\d*\(localeProvider.escapedDecimalSeparator)\\d$"
        trailingSeparatorAndDigitRegularExpression = try? NSRegularExpression(pattern: separatorAndDigitPattern, options: [])

    }
    
    func complete(_ amount: String?) -> String? {
        guard let amount = amount else {
            return nil
        }

        if amount.count == 0 {
            return "0" + localeProvider.decimalSeparator + "00"
        }
        if string(amount, matches: trailingSeparatorAndDigitRegularExpression) {
            return amount + "0"
        }
        if string(amount, matches: trailingSeparatorRegularExpression) {
            return amount + "00"
        }
        if string(amount, matches: trailingDigitRegularExpression) {
            return amount + localeProvider.decimalSeparator + "00"
        }
        
        return amount
    }
    
    private func string(_ string: String, matches regularExpression: NSRegularExpression?) -> Bool {
        let range = NSRange(location: 0, length: string.count)
        let matches = regularExpression?.numberOfMatches(in: string, options: [], range: range) == 1
        return matches
    }
    
}
