//
//  UserRecipeUploadView.swift
//  FridgeFeastFinder
//
//  Created by Haseeb Hussain on 12/2/23.
//

import UIKit

class UserRecipeUploadView: UIView {
    
    var imageView: UIButton!
    var commentTextField: UITextField!
    var uploadButton: UIButton!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupImageView()
        setupCommentTextField()
        setupUploadButton()
        initConstraints()
    }
    
    func setupImageView() {
        imageView = UIButton(type: .system)
        imageView.setTitle("", for: .normal)
        imageView.setImage(UIImage(systemName: "camera"), for: .normal)
        imageView.tintColor = .black
        imageView.showsMenuAsPrimaryAction = true
        imageView.contentHorizontalAlignment = .fill
        imageView.contentVerticalAlignment = .fill
        imageView.imageView?.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageView)
    }
    
    func setupCommentTextField() {
        commentTextField = UITextField()
        commentTextField.placeholder = "Add a comment..."
        commentTextField.borderStyle = .roundedRect
        commentTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(commentTextField)
    }
    
    func setupUploadButton() {
        uploadButton = UIButton(type: .system)
        uploadButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        uploadButton.setTitle("Share", for: .normal)
        uploadButton.translatesAutoresizingMaskIntoConstraints = false
        
        uploadButton.backgroundColor = .black
        uploadButton.setTitleColor(.white, for: .normal)
        uploadButton.layer.cornerRadius = 8.0
        uploadButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(uploadButton)
    }
    
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            // Image Button Constraints
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.widthAnchor.constraint(equalToConstant: 150),
            imageView.heightAnchor.constraint(equalToConstant: 150),

            // Comment Text Field Constraints
            commentTextField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            commentTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            commentTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            commentTextField.heightAnchor.constraint(equalToConstant: 40),

            // Upload Button Constraints
            uploadButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            uploadButton.topAnchor.constraint(equalTo: commentTextField.bottomAnchor, constant: 20),
            uploadButton.widthAnchor.constraint(equalToConstant: 120),
            uploadButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
