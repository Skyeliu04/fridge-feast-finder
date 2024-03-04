//
//  RecipeInstructionsAPICall.swift
//  FridgeFeastFinder
//
//  Created by Haotian Liu on 12/4/23.
//

import Foundation
import Alamofire

extension RecipeInstructionsViewController {
    func getRecipes(id: Int) {
        
        if var urlComponents = URLComponents(string: APIConfigs.baseURL + "/recipes/" + id.description + "/information") {
            // Adding query parameters to the URL
            urlComponents.queryItems = [
                URLQueryItem(name: "apiKey", value: APIConfigs.apiKey)
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
                                        let receivedData = try decoder.decode(RecipeInstructionResponse.self, from: data)
                                        
                                        let recipe  = RecipeInstructionResponse(id: receivedData.id, title: receivedData.title, image: receivedData.image, servings: receivedData.servings, sourceName: receivedData.sourceName, sourceUrl: receivedData.sourceUrl, instructions: receivedData.instructions)
                                        
                                        self.recipe = recipe
                                        
                                        // Join the paragraphs back with line breaks
                                        let paragraphs = recipe.instructions.components(separatedBy: ".")
                                        let stringWithLineBreaks = paragraphs.joined(separator: ".\n\n")
                                        self.recipeInstructionsScreen.imageView.sd_setImage(with: URL(string: recipe.image))
                                        self.recipeInstructionsScreen.titleLabel.text = recipe.title
                                        self.recipeInstructionsScreen.sourceButton.setTitle(recipe.sourceName, for: .normal)
                                        self.recipeInstructionsScreen.instructionsLabel.text = stringWithLineBreaks
                                        self.hideActivityIndicator()
                                        
                                        // Handle the received data as needed
                                    } catch {
                                        print(error.localizedDescription)
                                        self.showAlert(title: "Error" ,message: "something went wrong!")
                                        print("JSON could not be decoded!")
                                    }
                                    break
                                    
                                case 400...499:
                                    self.showAlert(title: "Error", message: "something went wrong!")
                                    print(data)
                                    // Handle client errors
                                    break
                                    
                                default:
                                    self.showAlert(title: "Error", message: "something went wrong!")
                                    print(data)
                                    // Handle other status codes
                                    break
                                }
                            }
                            
                            break
                            
                        case .failure(let error):
                            print(error)
                            self.showAlert(title: "Error", message: "check your internet connection and try again.")
                            // Handle network errors
                            break
                        }
                    })
            }
        }
    }
}

extension RecipeInstructionsViewController: ProgressSpinnerDelegate {
    func showActivityIndicator(){
        addChild(childProgressView)
        view.addSubview(childProgressView.view)
        childProgressView.didMove(toParent: self)
    }
    
    func hideActivityIndicator(){
        childProgressView.willMove(toParent: nil)
        childProgressView.view.removeFromSuperview()
        childProgressView.removeFromParent()
    }
}

