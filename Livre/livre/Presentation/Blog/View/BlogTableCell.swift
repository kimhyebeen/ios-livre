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
        self.backgroundColor = .clear
        
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
}

extension BlogTableCell {
    // MARK: Title Label
    private func setupTitleLabel() {
        title.text = "블로그 제목"
        title.numberOfLines = 0
        title.textColor = UIColor(named: "deep_gray")
        title.font = UIFont.boldSystemFont(ofSize: 17)
        self.addSubview(title)
        
        title.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(15)
            make.trailing.lessThanOrEqualToSuperview().offset(-15)
        }
    }
    
    // MARK: Post Date Label
    private func setupPostDateLabel() {
        postDate.text = "(작성일)"
        postDate.textColor = UIColor(named: "normal_gray")
        postDate.font = UIFont.systemFont(ofSize: 12)
        self.addSubview(postDate)
        
        postDate.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(-35)
            make.leading.equalToSuperview().offset(15)
            make.trailing.lessThanOrEqualToSuperview().offset(-15)
        }
    }
    
    // MARK: Description Label
    private func setupDescriptionLabel() {
        descriptionLabel.text = "블로그 내용"
        descriptionLabel.textColor = UIColor(named: "normal_gray")
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.numberOfLines = 2
        self.addSubview(descriptionLabel)
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(postDate.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(15)
            make.trailing.lessThanOrEqualToSuperview().offset(-15)
        }
    }
    
    // MARK: Blogger Name Label
    private func setupBloggerNameLabel() {
        bloggerName.text = "블로거 이름"
        bloggerName.textColor = UIColor(named: "soft_navy")
        bloggerName.font = UIFont.systemFont(ofSize: 13)
        self.addSubview(bloggerName)
        
        bloggerName.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            make.leading.greaterThanOrEqualToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
}
