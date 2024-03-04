//
//  FindByIngredientsResponse.swift
//  FridgeFeastFinder
//
//  Created by Haseeb Hussain on 12/2/23.
//

import Foundation

class FindByIngredientsResponse: Codable {
    
    let id: Int
    let image: String
    let missedIngredientCount: Int
    let title: String
    
    init(id: Int, image: String, missedIngredientCount: Int, title: String) {
        self.id = id
        self.image = image
        self.missedIngredientCount = missedIngredientCount
        self.title = title
    }
    
    
}

class Recipes: Codable {
    let recipes: [FindByIngredientsResponse]
    
    init(recipes: [FindByIngredientsResponse]) {
        self.recipes = recipes
    }
}
