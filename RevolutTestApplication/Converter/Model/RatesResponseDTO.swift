//
//  RatesResponseDTO.swift
//  RevolutTestApplication
//
//  Created by lg on 26/01/2019.
//  Copyright © 2019 lg. All rights reserved.
//

import Foundation

class RatesResponseDTO: Decodable {
    let base: String?
    let date: String?
    let rates: [String: Decimal]?
}
