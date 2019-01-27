//
//  LocalizationHelper.swift
//  RevolutTestApplication
//
//  Created by lg on 27/01/2019.
//  Copyright © 2019 lg. All rights reserved.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
