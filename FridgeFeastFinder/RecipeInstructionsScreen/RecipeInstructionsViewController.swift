//
//  RecipeInstructionsViewController.swift
//  FridgeFeastFinder
//
//  Created by Haotian Liu on 2023-11-30.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import Alamofire

class RecipeInstructionsViewController: UIViewController {
    
    let recipeInstructionsScreen = RecipeInstructionsView()
    
    let childProgressView = ProgressSpinnerViewController()
    
    var recipe: RecipeInstructionResponse?
    var id: Int?
    var isBookmarked = false
    
    // Firestore reference
    let firestoreDB = Firestore.firestore()
    
    // Firestore collection reference
    let bookmarksCollection = "bookmarks"
    
    // Get the current authenticated user
    let currentUser = Auth.auth().currentUser
    
    override func loadView() {
        view = recipeInstructionsScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Recipe Instructions: "
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .bookmarks, target: self, action: #selector(onBookmarksButtonTapped)
        )
        recipeInstructionsScreen.sourceButton.addTarget(self, action: #selector(onSourceClicked), for: .touchUpInside)
        self.showActivityIndicator()
        if let id = self.id {
            getRecipes(id: id)
        }
        checkBookmarkStatus()
        self.hideActivityIndicator()
        // Do any additional setup after loading the view.
    }
    
    @objc func onSourceClicked() {
        if let sourceURL = URL(string: recipe!.sourceUrl) {
            UIApplication.shared.open(sourceURL)
        }
    }
    
    @objc func onBookmarksButtonTapped() {
        guard let recipe = self.recipe, let userId = currentUser?.uid else {
            showAlert(title: "Error", message: "Recipe data not available.")
            return
        }
        
        let documentRef = firestoreDB.collection(bookmarksCollection).document(userId).collection("recipeId").document(recipe.id.description)
        
        if isBookmarked {
            // Recipe is already bookmarked, remove it
            removeBookmark(documentRef: documentRef)
        } else {
            // Recipe is not bookmarked, add it
            addBookmark(documentRef: documentRef, recipe: recipe)
        }
    }
    
    func checkBookmarkStatus() {
        guard let userId = currentUser?.uid else {
            showAlert(title: "Error", message: "User not authenticated.")
            return
        }

        if let id = self.id {
            let documentRef = firestoreDB.collection(bookmarksCollection).document(userId).collection("recipeId").document(id.description)
            documentRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    // Recipe is bookmarked
                    self.isBookmarked = true
                } else {
                    // Recipe is not bookmarked
                    self.isBookmarked = false
                }

                // Update the bookmark button based on the status
                self.updateBookmarkButton()
            }
        }
    }
    
    func addBookmark(documentRef: DocumentReference, recipe: RecipeInstructionResponse) {
        documentRef.setData([
            "id": recipe.id,
            "title": recipe.title,
            "image": recipe.image,
            "servings": recipe.servings,
            "sourceName": recipe.sourceName,
            "sourceUrl": recipe.sourceUrl,
            "instructions": recipe.instructions
        ]) { error in
            if let error = error {
                self.showAlert(title: "Error", message: "Failed to bookmark recipe. \(error.localizedDescription)")
            } else {
                // Bookmark added successfully
                self.isBookmarked = true
                self.updateBookmarkButton()
                self.showAlert(title: "Success",message: "Recipe bookmarked successfully.")
            }
        }
    }
    
    func removeBookmark(documentRef: DocumentReference) {
        documentRef.delete { error in
            if let error = error {
                self.showAlert(title: "Error", message: "Failed to remove bookmark. \(error.localizedDescription)")
            } else {
                // Bookmark removed successfully
                self.isBookmarked = false
                self.updateBookmarkButton()
                self.showAlert(title: "Success", message: "Recipe removed from bookmarks.")
            }
        }
    }
    
    func updateBookmarkButton() {
        // Update the UI based on bookmark status
        let bookmarkIcon = isBookmarked ? "book.fill" : "book"
        let newBookmarkButton = UIBarButtonItem(image: UIImage(systemName: bookmarkIcon),
                                                style: .plain,
                                                target: self,
                                                action: #selector(onBookmarksButtonTapped))
        navigationItem.rightBarButtonItem = newBookmarkButton
    }
    
    
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

