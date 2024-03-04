//
//  ViewController.swift
//  FridgeFeastFinder
//
//  Created by Haseeb Hussain on 11/16/23.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    let mainView = MainView()
    let tabBarVC = FFFTabBarController()
    let notificationCenter = NotificationCenter.default

    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        mainView.loginButton.addTarget(self, action: #selector(onButtonSignInTapped), for: .touchUpInside)
        mainView.createAccButton.addTarget(self, action: #selector(onButtonCreateAccTapped), for: .touchUpInside)
        notificationCenter.addObserver(
                    self,
                    selector: #selector(popOutTabBar(notification:)),
                    name: Notification.Name("textFromSecondScreen"),
                    object: nil)

        // Check if the user is logged in using Firebase Authentication
        if let currentUser = Auth.auth().currentUser {
            print("User is logged in with UID: \(currentUser.uid)")
            // showTabBar()
            let tabBarVC = FFFTabBarController()
            tabBarVC.navigationItem.hidesBackButton = true
            self.navigationController?.pushViewController(tabBarVC, animated: true)
        } else {
            print("User is not logged in")
            // showMainView()
        }
    }
    
    @objc func popOutTabBar(notification: Notification) {
        navigationController?.popViewController(animated: false)
        
        if let viewControllers = self.navigationController?.viewControllers {
            
            for viewController in viewControllers {
                
                if viewController is ViewController {
                    
                    self.navigationController?.popToViewController(viewController, animated: true)
                    print("popped")
                    
                }
                
            }
        }
    }

    @objc func onButtonSignInTapped() {
        let signInViewController = SignInViewController()
        navigationController?.pushViewController(signInViewController, animated: true)
    }

    @objc func onButtonCreateAccTapped() {
        let createAccountViewController = CreateAccountViewController()
        navigationController?.pushViewController(createAccountViewController, animated: true)
    }

    func showTabBar() {
            navigationController?.setViewControllers([self, tabBarVC], animated: true)
        }

        func showMainView() {
            navigationController?.setViewControllers([self], animated: true)
        }
}

