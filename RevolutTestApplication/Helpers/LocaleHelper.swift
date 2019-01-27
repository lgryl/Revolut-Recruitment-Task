//
//  LocaleHelper.swift
//  RevolutTestApplication
//
//  Created by lg on 27/01/2019.
//  Copyright © 2019 lg. All rights reserved.
//

import Foundation

class LocaleHelper {
    
    static var decimalSeparator: String {
        let separator = Locale.current.decimalSeparator ?? "."
        return separator
    }
    
    static var escapedDecimalSeparator: String {
        var separator = LocaleHelper.decimalSeparator
        if separator == "." {
            separator = "\\."
        }
        return separator
    }
    
}
