//
//  FakeLocaleProvider.swift
//  RevolutTestApplicationTests
//
//  Created by lg on 29/01/2019.
//  Copyright © 2019 lg. All rights reserved.
//

import Foundation
@testable import RevolutTestApplication

class FakeLocaleProvider: LocaleProvider {
    
    let separator: String
    
    init(separator: String) {
        self.separator = separator
    }
    
    override var decimalSeparator: String {
        return separator
    }
    
}
