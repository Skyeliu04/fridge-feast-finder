//
//  User.swift
//  FridgeFeastFinder
//
//  Created by Haseeb Hussain on 12/1/23.
//

import Foundation
import FirebaseFirestoreSwift


struct User: Codable, Identifiable {
    @DocumentID var id: String?
    let uid, email, profileImageUrl: String
}
