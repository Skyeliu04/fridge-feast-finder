//
//  CreateProgressIndicatorManager.swift
//  FridgeFeastFinder
//
//  Created by Haotian Liu on 11/27/23.
//

import Foundation

extension CreateAccountViewController:ProgressSpinnerDelegate {
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
