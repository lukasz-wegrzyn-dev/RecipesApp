//
//  HomeInteractor.swift
//  RecipesApp
//
//  Created by acon on 20/08/2020.
//  Copyright © 2020 acon. All rights reserved.
//

import Foundation

class HomeInteractor {
    private var networkService: NetworkServiceInterface
    
    init(networkService: NetworkServiceInterface) {
        self.networkService = networkService
    }
}

//MARK: Interface
protocol HomeInteracting: class {
    func search(query: String, completion: @escaping (_ result: Result<[Recipe], Error>)->Void)
}

extension HomeInteractor: HomeInteracting {
    func search(query: String, completion: @escaping (Result<[Recipe], Error>) -> Void) {
        self.networkService.search(query: query, completion: completion)
    }
}
