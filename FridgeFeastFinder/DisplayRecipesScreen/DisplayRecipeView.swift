//
//  DisplayRecipeView.swift
//  FridgeFeastFinder
//
//  Created by Katherine Davis on 2023-11-27.
//

import UIKit

class DisplayRecipesView: UIView {
    
    var tableViewRecipes: UITableView!
    var backButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        //MARK: initializing a TableView...
        setupTableViewContacts()
        initConstraints()
    }
    
    func setupTableViewContacts(){
        tableViewRecipes = UITableView()
        tableViewRecipes.register(RecipesTableViewCell.self, forCellReuseIdentifier: "recipes")
        tableViewRecipes.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableViewRecipes)
    }
    
    //MARK: setting the constraints...
    func initConstraints(){
        NSLayoutConstraint.activate([
            tableViewRecipes.topAnchor.constraint(equalTo: self.topAnchor),
            tableViewRecipes.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableViewRecipes.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableViewRecipes.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
