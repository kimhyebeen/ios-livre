//
//  BookCollectionCell.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/20.
//

import UIKit

class BookCollectionCell: UICollectionViewCell {
    static let identifier = "BookCollectionCell"
    let screenWidth = UIScreen.main.bounds.width
    let title = UILabel()
        .then {
            $0.text = "책 제목"
            $0.textColor = UIColor(named: "pale_gray")
            $0.font = UIFont.boldSystemFont(ofSize: 17)
        }
    let author = UILabel()
        .then {
            $0.text = "저자: -"
            $0.textColor = UIColor(named: "blight_gray")
            $0.font = UIFont.systemFont(ofSize: 14)
        }
    let publishDate = UILabel()
        .then {
            $0.text = "출간일: -"
            $0.textColor = UIColor(named: "blight_gray")
            $0.font = UIFont.systemFont(ofSize: 14)
        }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
    }
    
    func setupView() {
        self.backgroundColor = UIColor(named: "deep_gray")?.withAlphaComponent(0.2)
        self.layer.cornerRadius = 10
        self.layer.shadowRadius = 10
        self.layer.shadowOpacity = 1
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        setupTitleLabel()
        setupAuthorLabel()
        setupPublishDateLabel()
        setupImageView()
    }
    
    private func setupTitleLabel() {
        self.addSubview(title)
        
        title.translatesAutoresizingMaskIntoConstraints = false
        title.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: screenWidth * 0.5 * 0.35).isActive = true
        title.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -10).isActive = true
    }
    
    private func setupAuthorLabel() {
        self.addSubview(author)
        
        author.translatesAutoresizingMaskIntoConstraints = false
        author.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 12).isActive = true
        author.leadingAnchor.constraint(equalTo: title.leadingAnchor).isActive = true
        author.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -10).isActive = true
    }
    
    private func setupPublishDateLabel() {
        self.addSubview(publishDate)
        
        publishDate.translatesAutoresizingMaskIntoConstraints = false
        publishDate.topAnchor.constraint(equalTo: author.bottomAnchor, constant: 6).isActive = true
        publishDate.leadingAnchor.constraint(equalTo: author.leadingAnchor).isActive = true
        publishDate.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -10).isActive = true
        publishDate.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
    }
    
    private func setupImageView() {
        
    }
}

/*
 var title: String
 var image: String
 var author: String
 var publishDate: Date?
 var isbn: String
 
 var publishDateString: String {
     let formatter = DateFormatter().then {
         $0.dateFormat = "yyyy-MM-dd"
     }
     if let pd = publishDate { return "출간일: \(formatter.string(from: pd))" }
     else { return "출간일: -" }
 }
 */
