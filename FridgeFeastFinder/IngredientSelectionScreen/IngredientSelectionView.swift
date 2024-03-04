//
//  IngredientSelectionView.swift
//  FridgeFeastFinder
//
//  Created by Katherine Davis on 2023-11-27.
//

import UIKit

class IngredientSelectionView: UIView {

    var tableViewIngredients: UITableView!
    var searchRecipeButton: UIButton!
    var welcomeLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.backgroundColor = .systemBackground
        
        setupTableViewIngredients()
        setupSearchRecipeButton()
        setupWelcomeLabel()
        
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupTableViewIngredients(){
        tableViewIngredients = UITableView()
        tableViewIngredients.register(IngredientSelectionTableViewCell.self, forCellReuseIdentifier: "ingredients")
        tableViewIngredients.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableViewIngredients)
    }
    
    func setupSearchRecipeButton(){
        searchRecipeButton = UIButton(type: .system)
        searchRecipeButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        searchRecipeButton.setTitle("Search Recipe", for: .normal)
        searchRecipeButton.translatesAutoresizingMaskIntoConstraints = false
        
        searchRecipeButton.backgroundColor = .black
        searchRecipeButton.setTitleColor(.white, for: .normal)
        searchRecipeButton.layer.cornerRadius = 8.0
        
        self.addSubview(searchRecipeButton)
    }
    
    func setupWelcomeLabel(){
        welcomeLabel = UILabel()
        welcomeLabel.text = "Add your ingredients here. Swipe left to delete."
        welcomeLabel.font = .boldSystemFont(ofSize: 16)
        welcomeLabel.textColor = .black
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(welcomeLabel)

    }
    
    func initConstraints(){
        
        let margins = self.layoutMarginsGuide
        NSLayoutConstraint.activate([
            
            welcomeLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
            welcomeLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            welcomeLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            
            
            tableViewIngredients.topAnchor.constraint(equalTo: welcomeLabel.safeAreaLayoutGuide.topAnchor, constant: 32),
            tableViewIngredients.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            tableViewIngredients.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            tableViewIngredients.bottomAnchor.constraint(equalTo: searchRecipeButton.topAnchor, constant: -8),
            
            searchRecipeButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 8),
            searchRecipeButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -8),
            searchRecipeButton.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -8),
            searchRecipeButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

}

