//
//  Ingredient.swift
//  FridgeFeastFinder
//
//  Created by Katherine Davis on 2023-11-30.
//

import Foundation

struct Ingredient: Codable {
    var ingredientName: String
    
    init(ingredientName: String){
        self.ingredientName = ingredientName
    }
}
