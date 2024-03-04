//
//  BookmarksView.swift
//  FridgeFeastFinder
//
//  Created by Haotian Liu on 12/5/23.
//

import UIKit

class BookmarksView: UIView {

    var tableViewBookmarks: UITableView!
    var backButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        //MARK: initializing a TableView...
        setupTableViewContacts()
        initConstraints()
    }
    
    func setupTableViewContacts(){
        tableViewBookmarks = UITableView()
        tableViewBookmarks.register(BookmarksTableViewCell.self, forCellReuseIdentifier: "bookmarks")
        tableViewBookmarks.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableViewBookmarks)
    }
    
    //MARK: setting the constraints...
    func initConstraints(){
        NSLayoutConstraint.activate([
            tableViewBookmarks.topAnchor.constraint(equalTo: self.topAnchor),
            tableViewBookmarks.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableViewBookmarks.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableViewBookmarks.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
