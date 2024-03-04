//
//  Validations.swift
//  FridgeFeastFinder
//
//  Created by Haotian Liu on 11/27/23.
//

import Foundation
import UIKit

func isValidEmail(_ email: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: email)
}

func isValidPassword(_ password: String, confirmPassword: String) -> Bool {
    
    // Check if passwords are the same
    guard password == confirmPassword else {
        return false
    }

    // Check if password length is greater than 6
    guard password.count > 6 else {
        return false
    }

    return true
}
