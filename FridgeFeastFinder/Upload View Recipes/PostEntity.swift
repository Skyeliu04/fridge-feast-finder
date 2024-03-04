//
//  PostEntity.swift
//  FridgeFeastFinder
//
//  Created by Haseeb Hussain on 12/2/23.
//

import Foundation

class PostEntity {

    var email: String
    var comment: String
    var imageUrl: String
    var likes: Int
    var isLiked: Bool
    var postId: String

    init(email: String, comment: String, imageUrl: String, likes: Int, isLiked: Bool, postId: String) {
        self.email = email
        self.comment = comment
        self.imageUrl = imageUrl
        self.likes = likes
        self.isLiked = isLiked
        self.postId = postId
    }
}
