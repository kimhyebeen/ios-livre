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
    let postDate = UILabel()
    let descriptionLabel = UILabel()
    let bloggerName = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.layer.cornerRadius = 10
        self.backgroundColor = UIColor.white.withAlphaComponent(0)
        
        setupTitleLabel()
        setupPostDateLabel()
        setupDescriptionLabel()
        setupBloggerNameLabel()
    }
    
    func setBlogInformtaion(item: BlogItem) {
        title.attributedText = item.title
            .htmlEscapedAttributedString(font: UIFont.boldSystemFont(ofSize: 17), colorHex: "2C2C2C", lineSpacing: 1)
        postDate.text = item.postDateString
        descriptionLabel.attributedText = item.description
            .htmlEscapedAttributedString(font: UIFont.systemFont(ofSize: 14), colorHex: "4C4C4C", lineSpacing: 1)
        bloggerName.text = item.bloggername
    }
    
    func setLightMode() {
        title.textColor = UIColor(named: "deep_gray")
        postDate.textColor = UIColor(named: "blight_gray")
        descriptionLabel.textColor = UIColor(named: "deep_gray")
        bloggerName.textColor = UIColor(named: "blight_gray")
    }
}

extension BlogTableCell {
    // MARK: Title Label
    private func setupTitleLabel() {
        title.text = "블로그 제목"
        title.numberOfLines = 0
        title.textColor = UIColor(named: "deep_gray")
        title.font = UIFont.boldSystemFont(ofSize: 17)
        self.addSubview(title)
        
        title.translatesAutoresizingMaskIntoConstraints = false
        title.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        title.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -15).isActive = true
    }
    
    // MARK: Post Date Label
    private func setupPostDateLabel() {
        postDate.text = "(작성일)"
        postDate.textColor = .systemGray
        postDate.font = UIFont.systemFont(ofSize: 12)
        self.addSubview(postDate)
        
        postDate.translatesAutoresizingMaskIntoConstraints = false
        postDate.topAnchor.constraint(equalTo: title.bottomAnchor, constant: -35).isActive = true
        postDate.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        postDate.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -15).isActive = true
    }
    
    // MARK: Description Label
    private func setupDescriptionLabel() {
        descriptionLabel.text = "블로그 내용"
        descriptionLabel.textColor = UIColor(named: "normal_gray")
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.numberOfLines = 3
        self.addSubview(descriptionLabel)
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(equalTo: postDate.bottomAnchor, constant: 8).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        descriptionLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -15).isActive = true
    }
    
    // MARK: Blogger Name Label
    private func setupBloggerNameLabel() {
        bloggerName.text = "블로거 이름"
        bloggerName.textColor = .systemGray
        bloggerName.font = UIFont.systemFont(ofSize: 13)
        self.addSubview(bloggerName)
        
        bloggerName.translatesAutoresizingMaskIntoConstraints = false
        bloggerName.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8).isActive = true
        bloggerName.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor, constant: 15).isActive = true
        bloggerName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
        bloggerName.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
    }
}
