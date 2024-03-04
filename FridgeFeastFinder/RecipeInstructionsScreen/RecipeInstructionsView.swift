//
//  RecipeInstructionsView.swift
//  FridgeFeastFinder
//
//  Created by Haotian Liu on 2023-11-30.
//

import UIKit

class RecipeInstructionsView: UIView {
    
    var titleLabel: UILabel!
    var imageView: UIImageView!
    var sourceButton: UIButton!
    var scrollView: UIScrollView!
    var instructionsLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white

        setupTitleLabel()
        setupImageView()
        setupSourceButton()
        setupScrollView()
        setupInstructionsLabel()
        initConstraints()
    }
    
    func setupTitleLabel() {
        titleLabel = UILabel()
        titleLabel.font = .boldSystemFont(ofSize: 28)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
    }
    
    func setupImageView() {
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
    }
    
    func setupSourceButton() {
        sourceButton = UIButton(type: .system)
        sourceButton.titleLabel?.font = .italicSystemFont(ofSize: 18)
        sourceButton.setTitleColor(.blue, for: .normal)
        sourceButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(sourceButton)
    }
    
    func setupScrollView() {
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(scrollView)
    }
    
    func setupInstructionsLabel() {
        instructionsLabel = UILabel()
        instructionsLabel.font = .systemFont(ofSize: 16)
        instructionsLabel.numberOfLines = 0
        instructionsLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(instructionsLabel)
    }

    func initConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4),
            
            sourceButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            sourceButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            sourceButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            scrollView.topAnchor.constraint(equalTo: sourceButton.bottomAnchor, constant: 10),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            
            instructionsLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            instructionsLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            instructionsLabel.topAnchor.constraint(equalTo: scrollView.topAnchor),
            instructionsLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor),  // Make it horizontal
            instructionsLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
