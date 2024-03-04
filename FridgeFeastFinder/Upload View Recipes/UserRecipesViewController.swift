//
//  UserRecipesViewController.swift
//  FridgeFeastFinder
//
//  Created by Haseeb Hussain on 12/2/23.
//

import UIKit
import Firebase

class UserRecipesViewController: UIViewController {

    let userRecipesView = UserRecipeView()
    var postArray = [PostEntity]()
    
    override func loadView() {
        view = userRecipesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "User Recipes"
        userRecipesView.tableViewUserRecipes.separatorStyle = .none
        userRecipesView.tableViewUserRecipes.dataSource = self
        userRecipesView.tableViewUserRecipes.delegate = self
        var newArray = [PostEntity]()
        let postEntity = PostEntity(email: "", comment: "", imageUrl: "https://uploads.dailydot.com/e52/31/87610fa1a0ae891d.png?auto=compress&fm=png", likes: 0, isLiked: false,postId: "null")
        newArray.append(postEntity)
        self.postArray = newArray
        getDataFireBase()
    }
    
    func getDataFireBase() {
        let fireStoreDb = Firestore.firestore()
        fireStoreDb.collection("Post")
            .addSnapshotListener { snapshot, error in
                if error != nil {
                    // Handle the error
                    print("Error:" + (error!.localizedDescription))
                } else {
                    if let snapshot = snapshot, !snapshot.isEmpty {
                        var newArray = [PostEntity]()
                        print("in user recipe")
                        
                        for doc in snapshot.documents {
                            if
                                let imageUrl = doc.get("imageUrl") as? String,
                                let email = doc.get("email") as? String,
                                let comment = doc.get("comment") as? String
                            {
                                let postEntity = PostEntity(email: email, comment: comment, imageUrl: imageUrl, likes: 0, isLiked: false,postId: "null")
                                newArray.append(postEntity)
                            }
                        }
                        
                        self.postArray = newArray
                        self.userRecipesView.tableViewUserRecipes.reloadData()
                    } else {
                        var newArray = [PostEntity]()
                        let postEntity = PostEntity(email: "", comment: "", imageUrl: "https://uploads.dailydot.com/e52/31/87610fa1a0ae891d.png?auto=compress&fm=png", likes: 0, isLiked: false,postId: "null")
                        newArray.append(postEntity)
                        self.postArray = newArray
                        print("Empty")
                    }
                }
            }
    }
    
}


extension UserRecipesViewController: UITableViewDelegate, UITableViewDataSource{
    //MARK: returns the number of rows in the current section...
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
    
    //MARK: populate a cell for the currecnt row...
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userrecipes", for: indexPath) as! UserRecipesTableViewCell
        cell.commentText.text = postArray[indexPath.row].comment
        cell.emailText.text = postArray[indexPath.row].email
        cell.postImageView.sd_setImage(with: URL(string: self.postArray[indexPath.row].imageUrl))
        return cell
    }
    
    //MARK: deal with user interaction with a cell...
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // print(self.ingredients[indexPath.row])
    }
    
    
}
