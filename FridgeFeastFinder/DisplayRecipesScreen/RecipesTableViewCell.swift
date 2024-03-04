//
//  RecipesTableViewCell.swift
//  FridgeFeastFinder
//
//  Created by Katherine Davis on 2023-11-27.
//

import UIKit

class RecipesTableViewCell: UITableViewCell {
    
    var wrapperCellView: UIView!
    var recipeName: UILabel!
    var listOfIngredients: UILabel!
    var recipeImage: UIImageView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupWrapperCellView()
        setupRecipeNameLabel()
        // setupIngredientList()
        setupRecipeImage()
        
        initConstraints()
        
    }
    
    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupWrapperCellView() {
        wrapperCellView = UIView()
        wrapperCellView.backgroundColor = .white
        wrapperCellView.layer.cornerRadius = 4.0
        wrapperCellView.layer.shadowColor = UIColor.gray.cgColor
        wrapperCellView.layer.shadowOffset = .zero
        wrapperCellView.layer.shadowRadius = 2.0
        wrapperCellView.layer.shadowOpacity = 0.7
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(wrapperCellView)
    }
    
    func setupRecipeNameLabel(){
        recipeName = UILabel()
        recipeName.font = UIFont.boldSystemFont(ofSize: 14)
        recipeName.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(recipeName)
    }
    
    func setupIngredientList(){
        // needs to get the recipes from the recipes selected from the ingredient selection screen
    
    }
    
    func setupRecipeImage(){
        recipeImage = UIImageView()
        recipeImage.contentMode = .scaleAspectFill
        recipeImage.clipsToBounds = true
        recipeImage.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(recipeImage)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4),
            
            recipeImage.topAnchor.constraint(equalTo: wrapperCellView.topAnchor),
            recipeImage.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor),
            recipeImage.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor),
            recipeImage.heightAnchor.constraint(equalTo: wrapperCellView.widthAnchor, multiplier: 0.6), // Adjust the multiplier as needed
            
            recipeName.topAnchor.constraint(equalTo: recipeImage.bottomAnchor, constant: 8),
            recipeName.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 8),
            recipeName.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -8),
            recipeName.bottomAnchor.constraint(equalTo: wrapperCellView.bottomAnchor, constant: -8)
        ])
    }
}
