//
//  Mocks.swift
//  RecipesAppTests
//
//  Created by acon on 20/08/2020.
//  Copyright © 2020 acon. All rights reserved.
//

import Foundation
@testable import RecipesApp

class MockNetworkService: NetworkServiceInterface {
    var recipes: [Recipe] = [
        Recipe(title: "Receipe1", imageUrl: "", ingredientLines: ["ing1", "ing2", "oing3"]),
        Recipe(title: "Receipe2", imageUrl: "", ingredientLines: ["ing1", "ing2", "oing3"]),
        Recipe(title: "Receipe3", imageUrl: "", ingredientLines: ["ing1", "ing2", "oing3"]),
        Recipe(title: "Receipe4", imageUrl: "", ingredientLines: ["ing1", "ing2", "oing3"]),
        Recipe(title: "Receipe5", imageUrl: "", ingredientLines: ["ing1", "ing2", "oing3"]),
        Recipe(title: "Receipe6", imageUrl: "", ingredientLines: ["ing1", "ing2", "oing3"]),
        Recipe(title: "Receipe7", imageUrl: "", ingredientLines: ["ing1", "ing2", "oing3"]),
    ]
    func search(query: String, completion: @escaping (Result<[Recipe], Error>) -> Void) {
        completion(.success(self.recipes))
    }
}
