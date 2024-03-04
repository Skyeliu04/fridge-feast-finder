//
//  IngredientSelectionAPICall.swift
//  FridgeFeastFinder
//
//  Created by Haseeb Hussain on 12/3/23.
//

import Foundation
import Alamofire

extension IngredientSelectionViewController {
    func getRecipes(ingredients: [Ingredient]) {
        // Constructing the ingredients string by joining them with commas
        let ingredientsString = ingredients.map { $0.ingredientName }.joined(separator: ",+")
        print(ingredientsString)
        
        // Adding the ingredients string to the base URL
        if var urlComponents = URLComponents(string: APIConfigs.baseURL + APIConfigs.findByIngredients) {
            // Adding query parameters to the URL
            urlComponents.queryItems = [
                URLQueryItem(name: "apiKey", value: APIConfigs.apiKey),
                URLQueryItem(name: "ingredients", value: ingredientsString)
            ]
            
            // Creating the final URL
            if let url = urlComponents.url {
                print(url)
                AF.request(url, method: .get)
                    .responseData(completionHandler: { response in
                        let status = response.response?.statusCode
                        
                        switch response.result {
                        case .success(let data):
                            
                            if let uwStatus = status {
                                switch uwStatus {
                                case 200...299:
                                    
                                    let decoder = JSONDecoder()
                                    
                                    do {
                                        let receivedData = try decoder.decode([FindByIngredientsResponse].self, from: data)
                                        let recipes = Recipes(recipes: receivedData)
                                        if recipes.recipes.isEmpty {
                                            self.showAlert(message: "No recipes found :(, please search with valid ingredient names.")
                                            return
                                        }
                                        let displayRecipeVC = DisplayRecipesViewController()
                                        displayRecipeVC.setRecipesToDisplay(recipes: recipes)
                                        self.navigationController?.pushViewController(displayRecipeVC, animated: true)
                                        // Handle the received data as needed
                                    } catch {
                                        self.showAlert(message: "something went wrong!")
                                        print(error.localizedDescription)
                                        print("JSON could not be decoded!")
                                    }
                                    break
                                    
                                case 400...499:
                                    self.showAlert(message: "something went wrong!")
                                    print(data)
                                    // Handle client errors
                                    break
                                    
                                default:
                                    self.showAlert(message: "something went wrong!")
                                    print(data)
                                    // Handle other status codes
                                    break
                                }
                            }
                            
                            break
                            
                        case .failure(let error):
                            print(error)
                            self.showAlert(message: "check your internet connection and try again.")
                            // Handle network errors
                            break
                        }
                    })
            }
        }
    }
}
