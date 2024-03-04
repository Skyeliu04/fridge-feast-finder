//
//  DashBoardView.swift
//  FridgeFeastFinder
//
//  Created by Haseeb Hussain on 11/27/23.
//

import UIKit

class DashBoardView: UIView {
    
    var logOutButton: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        // setupLoginButton()
        // setupConstraints()
    }
    
    
    func setupLoginButton() {
        logOutButton = UIButton(type: .system)
        logOutButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        logOutButton.setTitle("Log out", for: .normal)
        logOutButton.setTitleColor(.white, for: .normal)
        logOutButton.backgroundColor = .black
        logOutButton.layer.cornerRadius = 8
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(logOutButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            logOutButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logOutButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            logOutButton.widthAnchor.constraint(equalToConstant: 150), // Adjust width as needed
            logOutButton.heightAnchor.constraint(equalToConstant: 50) // Adjust height as needed
        ])
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
