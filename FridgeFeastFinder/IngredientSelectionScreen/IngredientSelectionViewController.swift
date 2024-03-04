//
//  IngredientSelectionViewController.swift
//  FridgeFeastFinder
//
//  Created by Katherine Davis on 2023-11-27.
//

import UIKit
import Alamofire

class IngredientSelectionViewController: UIViewController {
    
    let ingredientSelectionView = IngredientSelectionView()
    
    var ingredients = [Ingredient]()
    
    override func loadView() {
        view = ingredientSelectionView
        ingredientSelectionView.searchRecipeButton.addTarget(self, action: #selector(onSearchRecipeButtonTapped), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Ingredients"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add, target: self, action: #selector(onPlusButtonTapped)
        )
        
        ingredientSelectionView.tableViewIngredients.separatorStyle = .none
        ingredientSelectionView.tableViewIngredients.dataSource = self
        ingredientSelectionView.tableViewIngredients.delegate = self
        hideKeyboardOnTapOutside()
    }
    
    //MARK: hide keyboard logic...
    func hideKeyboardOnTapOutside(){
        //MARK: recognizing the taps on the app screen, not the keyboard...
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        tapRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapRecognizer)
    }
    
    //MARK: Hide Keyboard...
    @objc func hideKeyboardOnTap(){
        //MARK: removing the keyboard from screen...
        view.endEditing(true)
    }
    
    @objc func onSearchRecipeButtonTapped(){
        if (self.ingredients.isEmpty) {
            showAlert(message: "Add at least one ingredient to display Recipes.")
            return
        }
        getRecipes(ingredients: self.ingredients)
        
    }
    
    @objc func onPlusButtonTapped(){
        showAddIngredientAlert()
    }
    
    func showAddIngredientAlert(){
        let alert = UIAlertController(title: "New Ingredient", message: "Enter a name for this ingredient", preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "Name"
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self] _ in
            if let textField = alert.textFields?.first, let ingredientName = textField.text, !ingredientName.isEmpty {
                let newIngredient = Ingredient(ingredientName: ingredientName)
                self?.ingredients.append(newIngredient)
                self?.ingredientSelectionView.tableViewIngredients.reloadData()
            } else {
                self?.showEmptyTextFieldAlert()
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func showEmptyTextFieldAlert (){
        let emptyTextFieldAlert = UIAlertController(title: "Error", message: "Please enter an ingredient name", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        emptyTextFieldAlert.addAction(okAction)
        present(emptyTextFieldAlert, animated: true, completion: nil)
    }
}
 
extension IngredientSelectionViewController: UITableViewDelegate, UITableViewDataSource{
    //MARK: returns the number of rows in the current section...
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    //MARK: populate a cell for the currecnt row...
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredients", for: indexPath) as! IngredientSelectionTableViewCell
        cell.ingredientName.text = ingredients[indexPath.row].ingredientName
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete"){
            [unowned self] action, view, completionHandler in
            self.ingredients.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            completionHandler(true)
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    //MARK: deal with user interaction with a cell...
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(self.ingredients[indexPath.row])
    }
    
    
}

