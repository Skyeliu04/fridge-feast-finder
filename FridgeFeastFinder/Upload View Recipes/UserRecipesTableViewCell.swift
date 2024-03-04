//
//  UserRecipesTableViewCell.swift
//  FridgeFeastFinder
//
//  Created by Haseeb Hussain on 12/2/23.
//

import UIKit

class UserRecipesTableViewCell: UITableViewCell {
    
    var wrapperCellView: UIView!
    var postImageView: UIImageView!
    var commentText: UILabel!
    var emailText: UILabel!
    var likeButton: UIButton!
    var likesCountLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    // MARK: - View Setup
    private func setupViews() {
        setupWrapperCellView()
        setupPostImageView()
        setupCommentTextLabel()
        setupEmailTextLabel()
        // setupLikeButton()
        setupLikesCountLabel()
        initConstraints()
    }
    
    func setupWrapperCellView() {
        wrapperCellView = UIView()
        wrapperCellView.backgroundColor = .white
        wrapperCellView.layer.cornerRadius = 4.0
        wrapperCellView.layer.shadowColor = UIColor.gray.cgColor
        wrapperCellView.layer.shadowOffset = .zero
        wrapperCellView.layer.shadowRadius = 2.0
        wrapperCellView.layer.shadowOpacity = 0.7
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(wrapperCellView)
    }
    
    func setupPostImageView() {
        postImageView = UIImageView()
        postImageView.contentMode = .scaleAspectFill
        postImageView.clipsToBounds = true
        postImageView.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(postImageView)
    }
    
    func setupCommentTextLabel() {
        commentText = UILabel()
        commentText.font = UIFont.systemFont(ofSize: 16)
        commentText.numberOfLines = 0
        commentText.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(commentText)
    }
    
    func setupEmailTextLabel() {
        emailText = UILabel()
        emailText.font = UIFont.boldSystemFont(ofSize: 14)
        emailText.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(emailText)
    }
    
    func setupLikeButton() {
        likeButton = UIButton()
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.tintColor = .red
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(likeButton)
    }
    
    func setupLikesCountLabel() {
        likesCountLabel = UILabel()
        likesCountLabel.font = UIFont.systemFont(ofSize: 14)
        likesCountLabel.textColor = .black
        likesCountLabel.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(likesCountLabel)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4),
            
            postImageView.topAnchor.constraint(equalTo: wrapperCellView.topAnchor),
            postImageView.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor),
            postImageView.heightAnchor.constraint(equalTo: postImageView.widthAnchor),
            
            commentText.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 8),
            commentText.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 8),
            commentText.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -8),
            
            likesCountLabel.topAnchor.constraint(equalTo: commentText.bottomAnchor, constant: 8),
            likesCountLabel.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 8),
            likesCountLabel.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -8),
            
            emailText.topAnchor.constraint(equalTo: likesCountLabel.bottomAnchor, constant: 8),
            emailText.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 8),
            emailText.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -8),
            emailText.bottomAnchor.constraint(equalTo: wrapperCellView.bottomAnchor, constant: -8),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

