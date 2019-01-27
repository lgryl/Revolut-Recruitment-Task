//
//  ApiRatesFetchService.swift
//  RevolutTestApplication
//
//  Created by lg on 27/01/2019.
//  Copyright © 2019 lg. All rights reserved.
//

import Foundation

class ApiFetchRatesService: RatesFetchService {
    
    static let url = URL(string: "https://revolut.duckdns.org/latest?base=EUR")!
    
    let networkProvider = NetworkProvider()
    
    func fetchRates(completion: @escaping ((RatesResponseDTO) -> ())) {
        let request = URLRequest(url: ApiFetchRatesService.url)
        networkProvider.fetch(request: request) { (result) in
            switch result {
            case .success(let data):
                print(data)
                do {
                    let response = try JSONDecoder().decode(RatesResponseDTO.self, from: data)
                    DispatchQueue.main.async {
                        completion(response)
                    }
                } catch {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
