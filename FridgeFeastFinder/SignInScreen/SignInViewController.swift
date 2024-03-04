//
//  SignInViewController.swift
//  FridgeFeastFinder
//
//  Created by Haotian Liu on 11/21/23.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {

    let signInView = SignInView()
    
    let childProgressView = ProgressSpinnerViewController()
    
    override func loadView() {
        view = signInView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        signInView.loginButton.addTarget(self, action: #selector(onLoginTapped), for: .touchUpInside)
        hideKeyboardOnTapOutside()
    }
    
    @objc func onLoginTapped() {
        guard let email = signInView.emailTextField.text, !email.isEmpty else {
            showAlert(message: "Please enter your email.")
            return
        }
        
        guard let password = signInView.passwordTextField.text, !password.isEmpty else {
            showAlert(message: "Please enter your password.")
            return
        }
        self.showActivityIndicator()
        signInToFireBase(email: email, password: password)
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
    
    func signInToFireBase(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (result, error) in
            guard let self = self else { return }

            if let error = error {
                self.showAlert(message: error.localizedDescription)
            } else {
                self.hideActivityIndicator()
                let tabBarVC = FFFTabBarController()
                tabBarVC.navigationItem.hidesBackButton = true
                self.navigationController?.pushViewController(tabBarVC, animated: true)
            }
        }
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
