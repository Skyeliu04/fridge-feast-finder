//
//  MainView.swift
//  FridgeFeastFinder
//
//  Created by Haseeb Hussain on 11/21/23.
//

import UIKit

class MainView: UIView {

    var loginButton: UIButton!
    var createAccButton: UIButton!
    var titleLabel: UILabel!
    var logoImageView: UIImageView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white

        setupTitleLabel()
        setupLogoImageView()
        setupButtonLogin()
        setupRegisterButton()
        initConstraints()
    }

    func setupTitleLabel() {
        titleLabel = UILabel()
        titleLabel.font = .boldSystemFont(ofSize: 40)
        titleLabel.text = "FridgeFeastFinder"
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleLabel)
    }

    func setupLogoImageView() {
        logoImageView = UIImageView(image: UIImage(named: "appImage"))
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(logoImageView)
    }

    func setupButtonLogin() {
        loginButton = UIButton(type: .system)
        loginButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        loginButton.setTitle("Sign In", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.backgroundColor = .black
        loginButton.layer.cornerRadius = 8 // Make button corners round
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(loginButton)
    }

    func setupRegisterButton() {
        createAccButton = UIButton(type: .system)
        createAccButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        createAccButton.setTitle("Create account", for: .normal)
        createAccButton.setTitleColor(.black, for: .normal)
        createAccButton.backgroundColor = .white
        createAccButton.layer.cornerRadius = 8
        createAccButton.layer.borderWidth = 1
        createAccButton.layer.borderColor = UIColor.black.cgColor
        createAccButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(createAccButton)
    }

    func initConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 40),

            logoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            logoImageView.widthAnchor.constraint(equalToConstant: 300), // Adjust width as needed
            logoImageView.heightAnchor.constraint(equalToConstant: 500), // Adjust height as needed

            createAccButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            createAccButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            createAccButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            createAccButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            createAccButton.heightAnchor.constraint(equalToConstant: 50),

            loginButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loginButton.bottomAnchor.constraint(equalTo: createAccButton.topAnchor, constant: -20),
            loginButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            loginButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

