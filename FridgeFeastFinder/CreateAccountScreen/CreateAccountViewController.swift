//
//  CreateAccountViewController.swift
//  FridgeFeastFinder
//
//  Created by Haotian Liu on 11/21/23.
//

import UIKit
import FirebaseAuth

class CreateAccountViewController: UIViewController {
    
    let createAccountView = CreateAccountView()
    
    let childProgressView = ProgressSpinnerViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = createAccountView
        createAccountView.createAccButton.addTarget(self, action: #selector(onCreateAccTapped), for: .touchUpInside)

        hideKeyboardOnTapOutside()
    }
    
    @objc func onCreateAccTapped(){
        //MARK: creating a new user on Firebase...
        createNewAccount()
    }
    
    //MARK: hide keyboard logic...
    func hideKeyboardOnTapOutside(){
        //MARK: recognizing the taps on the app screen, not the keyboard...
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        tapRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapRecognizer)
    }
    
    //MARK: Hide Keyboard...
    @objc func hideKeyboardOnTap(){
        //MARK: removing the keyboard from screen...
        view.endEditing(true)
    }
    
    func createNewAccount() {
        // showActivityIndicator()
        
        guard let name = createAccountView.textFieldName.text, !name.isEmpty else {
            showAlert(message: "Please enter your name.")
            return
        }
        
        guard let email = createAccountView.emailTextField.text, !email.isEmpty else {
            showAlert(message: "Please enter your email.")
            return
        }
        
        // Check for valid email
        if !isValidEmail(email) {
            showAlert(message: "Please enter a valid email.")
            return
        }
        
        guard let password1 = createAccountView.passwordTextField.text, !password1.isEmpty else {
            showAlert(message: "Please enter a password.")
            return
        }
        
        guard let password2 = createAccountView.confirmPasswordTextField.text, !password2.isEmpty else {
            showAlert(message: "Please confirm your password.")
            return
        }
        
        if !isValidPassword(password1, confirmPassword: password2) {
            showAlert(message: "Passwords do not match or are not strong enough.")
            return
        }
        
        self.showActivityIndicator()
        Auth.auth().createUser(withEmail: email, password: password1, completion: {result, error in
            if error == nil{
                //MARK: the user creation is successful...
                self.setNameOfTheUserInFirebaseAuth(name: name)
            }else{
                //MARK: there is a error creating the user...
                self.showAlert(message: "Error Creating profile: \(String(describing: error?.localizedDescription))")
                print(error!)
            }
        })
        
        
        
    }
    
    //MARK: We set the name of the user after we create the account...
    func setNameOfTheUserInFirebaseAuth(name: String){
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = name
        changeRequest?.commitChanges(completion: {(error) in
            if error == nil{
                //MARK: the profile update is successful...
                
                //MARK: hide the progress indicator...
                self.hideActivityIndicator()
                
                //MARK: pop the current controller...
                let tabBarVC = FFFTabBarController()
                tabBarVC.navigationItem.hidesBackButton = true;
                self.navigationController?.pushViewController(tabBarVC, animated: true)
                // self.navigationController?.popViewController(animated: true)
            }else{
                //MARK: there was an error updating the profile...
                self.showAlert(message: "Error Creating profile: \(String(describing: error?.localizedDescription))")
                print("Error occured: \(String(describing: error))")
            }
        })
    }
    
    func showAlert(message: String) {
            let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }

}
