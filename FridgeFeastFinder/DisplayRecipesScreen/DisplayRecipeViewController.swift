//
//  DisplayRecipeViewController.swift
//  FridgeFeastFinder
//
//  Created by Katherine Davis on 2023-11-27.
//

import UIKit

class DisplayRecipesViewController: UIViewController {
    
    let displayRecipesScreen = DisplayRecipesView()
    var searchText: String?
    var dataArray = [FindByIngredientsResponse]()
    let childProgressView = ProgressSpinnerViewController()

    
    override func loadView() {
        view = displayRecipesScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Recipes Found"
        displayRecipesScreen.tableViewRecipes.separatorStyle = .none
        displayRecipesScreen.tableViewRecipes.dataSource = self
        displayRecipesScreen.tableViewRecipes.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func setRecipesToDisplay(recipes: Recipes) {
        self.dataArray = recipes.recipes
        self.displayRecipesScreen.tableViewRecipes.reloadData()
        
    }
    
}


extension DisplayRecipesViewController: UITableViewDelegate, UITableViewDataSource{
    //MARK: returns the number of rows in the current section...
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    //MARK: populate a cell for the currecnt row...
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipes", for: indexPath) as! RecipesTableViewCell
        cell.recipeName.text = dataArray[indexPath.row].title
        cell.recipeImage.sd_setImage(with: URL(string: self.dataArray[indexPath.row].image))
        return cell
    }
    
    //MARK: deal with user interaction with a cell...
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(self.dataArray[indexPath.row])
        self.showActivityIndicator()
        let recipeDetailVC = RecipeInstructionsViewController()
        recipeDetailVC.id = dataArray[indexPath.row].id
        navigationController?.pushViewController(recipeDetailVC, animated: true)
        self.hideActivityIndicator()
    }
    
    
}

extension DisplayRecipesViewController: ProgressSpinnerDelegate {
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

