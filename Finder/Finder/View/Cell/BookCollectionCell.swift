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
    let imageView = UIImageView()
        .then {
            $0.image = UIImage(named: "empty_image")
            $0.contentMode = .scaleAspectFit
        }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
    }
    
    private func setupView() {
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
    
    func setBookInformation(item: SimpleBookItem) {
        title.attributedText = item.title
            .htmlEscaped(font: UIFont.boldSystemFont(ofSize: 17), colorHex: "F2F2F2", lineSpacing: 1)
        author.text = item.author
        publishDate.text = item.publishDateString
        loadImage(link: item.image)
    }
    
    private func loadImage(link: String) {
        DispatchQueue.global().async {
            guard let url: URL = URL(string: link) else {
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(named: "empty_image")
                }
                return
            }
            guard let imageData: Data = try? Data(contentsOf: url) else {
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(named: "empty_image")
                }
                return
            }
            
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: imageData)
            }
        }
    }
}

extension BookCollectionCell {
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
        self.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: title.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: publishDate.bottomAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        imageView.trailingAnchor.constraint(equalTo: title.leadingAnchor, constant: -12).isActive = true
    }
}
