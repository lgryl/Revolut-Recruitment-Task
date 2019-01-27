//
//  FakeRatesFetchService.swift
//  RevolutTestApplication
//
//  Created by lg on 27/01/2019.
//  Copyright © 2019 lg. All rights reserved.
//

import Foundation

class FakeRatesFetchService: RatesFetchService {
    
    func fetchRates(completion: @escaping ((RatesResponseDTO) -> ())) {
        let randomNumber = arc4random_uniform(3) + 1
        if let url = Bundle.main.url(forResource: "rates-0\(randomNumber)", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let response = try JSONDecoder().decode(RatesResponseDTO.self, from: data)
                completion(response)
            } catch {
                // TODO
            }
        }   
    }
}
