//
//  APIConfigs.swift
//  FridgeFeastFinder
//
//  Created by Haotian Liu on 11/30/23.
//

import Foundation
class APIConfigs{
    //MARK: API base URL
    static let baseURL = "https://api.spoonacular.com"
    
    static let apiKey = "472adf5246214b198b95112bb8a62e39"
    
    static var findByIngredients = "/recipes/findByIngredients"
    
    static var recipeProcedure = "/recipes/extract"
}
