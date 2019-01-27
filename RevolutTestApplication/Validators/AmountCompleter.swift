//
//  AmountCompleter.swift
//  RevolutTestApplication
//
//  Created by lg on 26/01/2019.
//  Copyright © 2019 lg. All rights reserved.
//

import Foundation

class AmountCompleter {
    
    static let digitRegularExpression: NSRegularExpression? = {
        let trailingDigitPattern = "^\\d*$"
        let trailingDigitRegularExpression = try? NSRegularExpression(pattern: trailingDigitPattern, options: [])
        return trailingDigitRegularExpression
    }()
    
    static let separatorRegularExpression: NSRegularExpression? = {
        let trailingSeparatorPattern = "^\\d*\(LocaleHelper.escapedDecimalSeparator)$"
        let trailingSeparatorRegularExpression = try? NSRegularExpression(pattern: trailingSeparatorPattern, options: [])
        return trailingSeparatorRegularExpression

    }()
    static let trailingSeparatorAndDigitRegularExpression: NSRegularExpression? = {
        let separatorAndDigitPattern = "^\\d*\(LocaleHelper.escapedDecimalSeparator)\\d$"
        let separatorAndDigitRegularExpression = try? NSRegularExpression(pattern: separatorAndDigitPattern, options: [])
        return separatorAndDigitRegularExpression
    }()
    
    func complete(_ amount: String?) -> String? {
        guard let amount = amount else {
            return nil
        }

        if amount.count == 0 {
            return "0" + LocaleHelper.decimalSeparator + "00"
        }
        if string(amount, matches: AmountCompleter.trailingSeparatorAndDigitRegularExpression) {
            return amount + "0"
        }
        if string(amount, matches: AmountCompleter.separatorRegularExpression) {
            return amount + "00"
        }
        if string(amount, matches: AmountCompleter.digitRegularExpression) {
            return amount + LocaleHelper.decimalSeparator + "00"
        }
        
        return amount
    }
    
    private func string(_ string: String, matches regularExpression: NSRegularExpression?) -> Bool {
        let range = NSRange(location: 0, length: string.count)
        let matches = regularExpression?.numberOfMatches(in: string, options: [], range: range) == 1
        return matches
    }
    
}
