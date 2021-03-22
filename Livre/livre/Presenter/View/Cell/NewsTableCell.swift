//
//  NewsTableCell.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/20.
//

import UIKit

class NewsTableCell: UITableViewCell {
    static let identifier = "NewsTableCell"
    let title = UILabel()
        .then {
            $0.text = "뉴스 제목"
            $0.numberOfLines = 0
            $0.textColor = UIColor(named: "deep_gray")
            $0.font = UIFont.boldSystemFont(ofSize: 17)
        }
    let publishDate = UILabel()
        .then {
            $0.text = "(작성일)"
            $0.textColor = .systemGray
            $0.font = UIFont.systemFont(ofSize: 12)
        }
    let descriptionLabel = UILabel()
        .then {
            $0.text = "뉴스 내용"
            $0.textColor = UIColor(named: "normal_gray")
            $0.font = UIFont.systemFont(ofSize: 14)
            $0.numberOfLines = 3
        }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.backgroundColor = UIColor.white.withAlphaComponent(0)
        
        setupTitleLabel()
        setupPublishDateLabel()
        setupDescriptionLabel()
    }
    
    func setNewsInformation(item: NewsItem) {
        title.attributedText = item.title
            .htmlEscapedAttributedString(font: UIFont.boldSystemFont(ofSize: 17), colorHex: "2C2C2C", lineSpacing: 1)
        publishDate.text = item.publishDateString
        descriptionLabel.attributedText = item.description
            .htmlEscapedAttributedString(font: UIFont.systemFont(ofSize: 14), colorHex: "4C4C4C", lineSpacing: 1)
    }
    
    func setLightMode() {
        title.textColor = UIColor(named: "deep_gray")
        publishDate.textColor = UIColor(named: "blight_gray")
        descriptionLabel.textColor = UIColor(named: "deep_gray")
    }

}

// MARK: +UI
extension NewsTableCell {
    private func setupTitleLabel() {
        self.addSubview(title)
        
        title.translatesAutoresizingMaskIntoConstraints = false
        title.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        title.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -15).isActive = true
    }
    
    private func setupPublishDateLabel() {
        self.addSubview(publishDate)
        
        publishDate.translatesAutoresizingMaskIntoConstraints = false
        publishDate.topAnchor.constraint(equalTo: title.bottomAnchor, constant: -35).isActive = true
        publishDate.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        publishDate.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -15).isActive = true
    }
    
    private func setupDescriptionLabel() {
        self.addSubview(descriptionLabel)
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(equalTo: publishDate.bottomAnchor, constant: 8).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        descriptionLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -15).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
    }
}
