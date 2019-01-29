//
//  LocaleProvider.swift
//  RevolutTestApplication
//
//  Created by lg on 28/01/2019.
//  Copyright © 2019 lg. All rights reserved.
//

import Foundation

class LocaleProvider {
    
    let locale: Locale
    
    init(locale: Locale = Locale.current) {
        self.locale = locale
    }
    
    var decimalSeparator: String {
        let separator = locale.decimalSeparator ?? "."
        return separator
    }
    
    var escapedDecimalSeparator: String {
        var separator = decimalSeparator
        if separator == "." {
            separator = "\\."
        }
        return separator
    }
    
}
