//
//  NetworkProvider.swift
//  RevolutTestApplication
//
//  Created by lg on 27/01/2019.
//  Copyright © 2019 lg. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(FetchError)
}

enum FetchError {
    case networkError
    case incorrectResponseError
    case incorrectStatusCode(Int)
    case parseError
}

class NetworkProvider {
    
    let session = URLSession(configuration: .default)
    
    func fetch(request: URLRequest, completion: @escaping (_ result: Result<Data>) -> ()) {
        session.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                completion(.failure(.networkError))
                return
            }
            if let response = response as? HTTPURLResponse {
                guard response.statusCode == 200 else {
                    let str  = String(data: data!, encoding: String.Encoding.utf8) as String?
                    print(str ?? "")
                    completion(.failure(.incorrectStatusCode(response.statusCode)))
                    return
                }
                if let data = data {
                    completion(.success(data))
                } else {
                    completion(.failure(.incorrectResponseError))
                }
            } else {
                completion(.failure(.incorrectResponseError))
            }
            }.resume()
    }
        
}
