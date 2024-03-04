//
//  RecipeInstructionResponse.swift
//  FridgeFeastFinder
//
//  Created by Katherine Davis on 2023-12-03.
//

import Foundation


struct RecipeInstructionResponse: Codable {
    
    let id: Int
    let title: String
    let image: String
    let servings: Int
    let sourceName: String
    let sourceUrl: String
    let instructions: String
    
    init(id: Int, title: String, image: String, servings: Int, sourceName: String, sourceUrl: String, instructions: String) {
        self.id = id
        self.title = title
        self.image = image
        self.servings = servings
        self.sourceName = sourceName
        self.sourceUrl = sourceUrl
        self.instructions = instructions
    }
}
