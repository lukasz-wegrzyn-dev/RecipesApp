//
//  Recipe.swift
//  RecipesApp
//
//  Created by acon on 20/08/2020.
//  Copyright © 2020 acon. All rights reserved.
//

import Foundation

class Recipe: Parsable {
    
    enum ReceipeRootCodingKeys: String, CodingKey {
        case recipe
    }
    enum CodingKeys: String, CodingKey {
        case title = "label"
        case imageUrl = "image"
        case ingredientLines
    }
    
    let title: String
    let imageUrl: String
    let ingredientLines: [String]
    
    required init(from decoder: Decoder) throws {
        
        let receipeContainer = try decoder.container(keyedBy: ReceipeRootCodingKeys.self)
        let container = try receipeContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .recipe)
        self.title = try container.decode(String.self, forKey: .title)
        self.imageUrl = try container.decode(String.self, forKey: .imageUrl)
        self.ingredientLines = try container.decode([String].self, forKey: .ingredientLines)
        try super.init(from: decoder)
    }
    
    init(title: String, imageUrl: String, ingredientLines: [String]) {
        self.title = title
        self.imageUrl = imageUrl
        self.ingredientLines = ingredientLines
        super.init()
    }
}

class Recipes: Parsable {
    enum CodingKeys: String, CodingKey {
        case hits
    }
    let recipes: [Recipe]
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.recipes = try container.decode([Recipe].self, forKey: .hits)
        try super.init(from: decoder)
    }
    
    init(recipes: [Recipe]) {
        self.recipes = recipes
        super.init()
    }
}
