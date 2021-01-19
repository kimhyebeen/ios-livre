//
//  BlogTableCell.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/20.
//

import UIKit

class BlogTableCell: UITableViewCell {
    static let identifier = "BlogTableCell"
    let title = UILabel()
        .then {
            $0.text = "블로그 제목"
            $0.textColor = UIColor(named: "deep_gray")
            $0.font = UIFont.boldSystemFont(ofSize: 17)
        }
    let postDate = UILabel()
        .then {
            $0.text = "작성일: -"
            $0.textColor = .systemGray
            $0.font = UIFont.systemFont(ofSize: 12)
        }
    let descriptionLabel = UILabel()
        .then {
            $0.text = "블로그 내용"
            $0.textColor = UIColor(named: "normal_gray")
            $0.font = UIFont.systemFont(ofSize: 14)
            $0.numberOfLines = 0
        }
    let bloggerName = UILabel()
        .then {
            $0.text = "블로거 이름"
            $0.textColor = .systemGray
            $0.font = UIFont.systemFont(ofSize: 12)
        }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.layer.cornerRadius = 10
        setupTitleLabel()
        setupPostDateLabel()
        setupDescriptionLabel()
        setupBloggerNameLabel()
    }
    
    func setBlogInformtaion(item: BlogItem) {
        
    }
}

extension BlogTableCell {
    private func setupTitleLabel() {
        self.addSubview(title)
        
        title.translatesAutoresizingMaskIntoConstraints = false
        title.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12).isActive = true
        title.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -12).isActive = true
    }
    
    private func setupPostDateLabel() {
        self.addSubview(postDate)
        
        postDate.translatesAutoresizingMaskIntoConstraints = false
        postDate.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 6).isActive = true
        postDate.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12).isActive = true
        postDate.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -12).isActive = true
    }
    
    private func setupDescriptionLabel() {
        self.addSubview(descriptionLabel)
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(equalTo: postDate.bottomAnchor, constant: 12).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12).isActive = true
        descriptionLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -12).isActive = true
    }
    
    private func setupBloggerNameLabel() {
        self.addSubview(bloggerName)
        
        bloggerName.translatesAutoresizingMaskIntoConstraints = false
        bloggerName.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 12).isActive = true
        bloggerName.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor, constant: 12).isActive = true
        bloggerName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12).isActive = true
        bloggerName.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
    }
}
