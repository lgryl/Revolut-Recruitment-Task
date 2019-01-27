//
//  RatesFetchService.swift
//  RevolutTestApplication
//
//  Created by lg on 26/01/2019.
//  Copyright © 2019 lg. All rights reserved.
//

import Foundation

protocol RatesFetchService {
    func fetchRates(completion: ((RatesResponseDTO) -> ()))
}

