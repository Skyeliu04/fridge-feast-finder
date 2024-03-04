//
//  ProfileView.swift
//  FridgeFeastFinder
//
//  Created by Haseeb Hussain on 11/28/23.
//

import UIKit

class ProfileView: UIView {
    
    var buttonTakePhoto: UIButton!
    var labelName: UILabel!
    var labelEmail: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupButtonTakePhoto()
        setupLabelName()
        setupLabelEmail()
        setupConstraints()
    }
    
    func setupButtonTakePhoto() {
        buttonTakePhoto = UIButton(type: .system)
        buttonTakePhoto.setTitle("", for: .normal)
        buttonTakePhoto.setImage(UIImage(systemName: "person.fill"), for: .normal)
        buttonTakePhoto.showsMenuAsPrimaryAction = true
        buttonTakePhoto.contentHorizontalAlignment = .fill
        buttonTakePhoto.contentVerticalAlignment = .fill
        buttonTakePhoto.imageView?.contentMode = .scaleAspectFit
        buttonTakePhoto.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonTakePhoto)
    }
    
    func setupLabelName() {
        labelName = UILabel()
        labelName.font = UIFont.boldSystemFont(ofSize: 30) // Make the title font bigger
        labelName.text = "loading...."
        labelName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelName)
    }
    
    func setupLabelEmail() {
        labelEmail = UILabel()
        labelEmail.font = labelEmail.font.withSize(30)
        labelEmail.text = "loading..."
        labelEmail.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelEmail)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            // Center the circular image button horizontally
            buttonTakePhoto.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            // Position the circular image button at the top with some top spacing
            buttonTakePhoto.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            // Set a fixed width and height for the circular image button
            buttonTakePhoto.widthAnchor.constraint(equalToConstant: 150),
            buttonTakePhoto.heightAnchor.constraint(equalToConstant: 150),
            
            // Position the labelName below the circular image button with spacing
            labelName.topAnchor.constraint(equalTo: buttonTakePhoto.bottomAnchor, constant: 20),
            labelName.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            // Position the labelEmail below the labelName with spacing
            labelEmail.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 10),
            labelEmail.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



