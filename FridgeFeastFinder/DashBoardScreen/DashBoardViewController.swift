//
//  DashBoardViewController.swift
//  FridgeFeastFinder
//
//  Created by Haseeb Hussain on 11/27/23.
//

import UIKit
import FirebaseAuth

class DashBoardViewController: UIViewController {
    
    let dashBoardView = DashBoardView()
    
    override func loadView() {
        view = dashBoardView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationItem.hidesBackButton = true
        // dashBoardView.logOutButton.addTarget(self, action: #selector(onLogoutTapped), for: .touchUpInside)
    }
    
//    @objc func onLogoutTapped(){
//        logoutFirebase()
//    }
//
//    func logoutFirebase() {
//        print("triggered")
//        let logoutAlert = UIAlertController(title: "Logging out!", message: "Are you sure want to log out?", preferredStyle: .actionSheet)
//        logoutAlert.addAction(UIAlertAction(title: "Yes, log out!", style: .default, handler: {(_) in
//            do{
//                try Auth.auth().signOut()
//                guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
//                // Call the function to reset the window's rootViewController
//                sceneDelegate.showMainApp()
//            }catch{
//                showErrorAlert(message: error.localizedDescription)
//                print("Error occured!")
//            }
//        })
//        )
//        logoutAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
//
//        self.present(logoutAlert, animated: true)
//    }
    
    
    
}
