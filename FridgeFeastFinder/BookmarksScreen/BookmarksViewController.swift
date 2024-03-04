//
//  BookmarksViewController.swift
//  FridgeFeastFinder
//
//  Created by Haotian Liu on 12/5/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class BookmarksViewController: UIViewController {
    
    let bookmarksScreen = BookmarksView()
    var dataArray = [BookMarksResponse]()
    
    override func loadView() {
        view = bookmarksScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Bookmarks"
        bookmarksScreen.tableViewBookmarks.separatorStyle = .none
        bookmarksScreen.tableViewBookmarks.dataSource = self
        bookmarksScreen.tableViewBookmarks.delegate = self
        
        // Do any additional setup after loading the view.
        fetchDataFromFirestore()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchDataFromFirestore()
    }
    
    
    func fetchDataFromFirestore() {
        guard let userId = Auth.auth().currentUser?.uid else {
            // User not authenticated
            return
        }
        
        let firestoreDB = Firestore.firestore()
        let bookmarksCollection = firestoreDB.collection("bookmarks")
        let userBookmarkCollection = bookmarksCollection.document(userId).collection("recipeId")
        
        userBookmarkCollection.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error fetching documents: \(error.localizedDescription)")
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                print("No documents found")
                return
            }
            
            // Clear existing data in dataArray
            self.dataArray.removeAll()
            
            for document in documents {
                do {
                    // Decode each document into BookMarksResponse
                    let jsonData = try JSONSerialization.data(withJSONObject: document.data())
                    let decoder = JSONDecoder()
                    let bookmark = try decoder.decode(BookMarksResponse.self, from: jsonData)
                    self.dataArray.append(bookmark)
                } catch {
                    print("Error decoding bookmark data: \(error.localizedDescription)")
                }
            }
            
            // Reload the table view to reflect the changes
            self.bookmarksScreen.tableViewBookmarks.reloadData()
            print("called")
        }
    }
    
}


extension BookmarksViewController: UITableViewDelegate, UITableViewDataSource{
    //MARK: returns the number of rows in the current section...
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    //MARK: populate a cell for the currecnt row...
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookmarks", for: indexPath) as! BookmarksTableViewCell
        cell.recipeName.text = dataArray[indexPath.row].title
        cell.recipeImage.sd_setImage(with: URL(string: self.dataArray[indexPath.row].image))
        return cell
    }
    
    //MARK: deal with user interaction with a cell...
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(self.dataArray[indexPath.row])
        // self.showActivityIndicator()
        let recipeDetailVC = RecipeInstructionsViewController()
        recipeDetailVC.id = dataArray[indexPath.row].id
        navigationController?.pushViewController(recipeDetailVC, animated: true)
        //  self.hideActivityIndicator()
    }

}

struct BookMarksResponse: Codable {
    let sourceUrl: String
    let id: Int
    let instructions: String
    let title: String
    let sourceName: String
    let servings: Int
    let image: String
}
