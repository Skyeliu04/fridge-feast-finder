//
//  UserRecipeView.swift
//  FridgeFeastFinder
//
//  Created by Haseeb Hussain on 12/2/23.
//

import UIKit

class UserRecipeView: UIView {
    var tableViewUserRecipes: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.backgroundColor = .systemBackground
        
        setupTableViewUserRecipes()
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTableViewUserRecipes(){
        tableViewUserRecipes = UITableView()
        tableViewUserRecipes.register(UserRecipesTableViewCell.self, forCellReuseIdentifier: "userrecipes")
        tableViewUserRecipes.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableViewUserRecipes)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            // Constrain the tableView to the edges of the UserRecipeView
            tableViewUserRecipes.topAnchor.constraint(equalTo: self.topAnchor),
            tableViewUserRecipes.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableViewUserRecipes.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableViewUserRecipes.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    
}
