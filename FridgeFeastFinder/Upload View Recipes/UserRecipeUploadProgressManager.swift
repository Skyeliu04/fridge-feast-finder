//
//  UserRecipeUploadProgressManager.swift
//  FridgeFeastFinder
//
//  Created by Haseeb Hussain on 12/3/23.
//

import Foundation

extension UserRecipeUploadViewController: ProgressSpinnerDelegate {
    func showActivityIndicator(){
        addChild(childProgressView)
        view.addSubview(childProgressView.view)
        childProgressView.didMove(toParent: self)
    }
    
    func hideActivityIndicator(){
        childProgressView.willMove(toParent: nil)
        childProgressView.view.removeFromSuperview()
        childProgressView.removeFromParent()
    }
}
