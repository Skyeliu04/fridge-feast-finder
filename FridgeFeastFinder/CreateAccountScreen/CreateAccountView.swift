//
//  CreateAccountView.swift
//  FridgeFeastFinder
//
//  Created by Haotian Liu on 11/21/23.
//

import UIKit

class CreateAccountView: UIView {

    var textFieldName: UITextField!
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var confirmPasswordTextField: UITextField!
    var createAccButton: UIButton!
    var createAccountLabel: UILabel!
    var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setuptextFieldName()
        setupEmailTextField()
        setupPasswordTextField()
        setupConfirmPasswordTextField()
        setupCreateAccButton()
        setupCreateAccLabel()
        setupTitleLabel()
        setupConstraints()
    }
    
    func setuptextFieldName(){
        textFieldName = UITextField()
        textFieldName.placeholder = "Name"
        textFieldName.keyboardType = .default
        textFieldName.borderStyle = .roundedRect
        textFieldName.autocapitalizationType = .none
        textFieldName.autocorrectionType = .no
        textFieldName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldName)
    }
    
    func setupEmailTextField() {
        emailTextField = UITextField()
        emailTextField.placeholder = "Email"
        emailTextField.borderStyle = .roundedRect
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        emailTextField.autocorrectionType = .no
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(emailTextField)
    }
    
    func setupPasswordTextField() {
        passwordTextField = UITextField()
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(passwordTextField)
    }
    
    func setupConfirmPasswordTextField() {
        confirmPasswordTextField = UITextField()
        confirmPasswordTextField.placeholder = "Confirm Password"
        confirmPasswordTextField.isSecureTextEntry = true
        confirmPasswordTextField.borderStyle = .roundedRect
        confirmPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(confirmPasswordTextField)
    }
    
    
    
    func setupCreateAccButton() {
        createAccButton = UIButton(type: .system)
        createAccButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        createAccButton.setTitle("Create account", for: .normal)
        createAccButton.setTitleColor(.white, for: .normal)
        createAccButton.backgroundColor = .black
        createAccButton.layer.cornerRadius = 8
        createAccButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(createAccButton)
    }
    
    func setupCreateAccLabel() {
        createAccountLabel = UILabel()
        createAccountLabel.text = "Create account"
        createAccountLabel.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.largeTitle)
        createAccountLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(createAccountLabel)
    }
    
    func setupTitleLabel() {
        titleLabel = UILabel()
        titleLabel.text = "FridgeFeastFinder"
        titleLabel.font = .boldSystemFont(ofSize: 40)
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleLabel)
    }
    
    func setupConstraints() {
        let margins = self.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: margins.topAnchor, constant: 40),
            
            // Added "Create account" label
            createAccountLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            createAccountLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            
            textFieldName.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20),
            textFieldName.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -20),
            textFieldName.topAnchor.constraint(equalTo: createAccountLabel.bottomAnchor, constant: 20),
            textFieldName.heightAnchor.constraint(equalToConstant: 50),
            
            emailTextField.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -20),
            emailTextField.topAnchor.constraint(equalTo: textFieldName.bottomAnchor, constant: 20),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTextField.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -20),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20),
            confirmPasswordTextField.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -20),
            confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            createAccButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20),
            createAccButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -20),
            createAccButton.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 40),
            createAccButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
