//
//  NetworkService.swift
//  HsbcDemo
//
//  Created by acon on 20/07/2020.
//  Copyright © 2020 acon. All rights reserved.
//

import Foundation

class NetworkService: NetworkServiceInterface {
    private let baseUrl = "https://api.edamam.com/"
    private let apiKey = "750a3a2158b7167de4d80107fae6f812"
    private let appId = "cfcc12f5"
    
    func search(query: String, completion: @escaping (_ result: Result<[Recipe], Error>)->Void) {
        let url = "\(baseUrl)search?q=\(query)&app_id=\(appId)&app_key=\(apiKey)&from=0&to=30"
        print(url)
        GET(urlString: url) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
                break
            case .success(let jsonString):
                if let json = jsonString.data(using: .utf8) {
                    Recipes.parse(json: json) { (recipes, error) in
                        if let error = error {
                            completion(.failure(error))
                        } else {
                            completion(.success((recipes as? Recipes)?.recipes ?? []))
                        }
                    }
                }
                break
            }
        }
    }
}

//MARK: Base requests
extension NetworkService {
    enum NetworkError: Error {
        case badUrl
    }
    
    private func GET(urlString: String, completion: @escaping (Result<String, Error>)->Void) {
        let session = URLSession.shared
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                completion(.failure(NetworkError.badUrl))
            }
            return
        }
        let task = session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    completion(.success(dataString))
                }
            }
        }
        task.resume()
    }
}

//MARK: NetworkService Interface
protocol NetworkServiceInterface {
    func search(query: String, completion: @escaping (_ result: Result<[Recipe], Error>)->Void)
}
