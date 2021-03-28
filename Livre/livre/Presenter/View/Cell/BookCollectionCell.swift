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
    let author = UILabel()
    let publishDate = UILabel()
    let imageView = UIImageView()
    
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
            .htmlEscapedAttributedString(font: UIFont.boldSystemFont(ofSize: 17), colorHex: "F2F2F2", lineSpacing: 1)
        author.attributedText = item.author
            .htmlEscapedAttributedString(font: UIFont.systemFont(ofSize: 14), colorHex: "D9D9D9", lineSpacing: 1)
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
    // MARK: Title Label
    private func setupTitleLabel() {
        title.text = "책 제목"
        title.textColor = UIColor(named: "pale_gray")
        title.font = UIFont.boldSystemFont(ofSize: 17)
        self.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: screenWidth * 0.5 * 0.35).isActive = true
        title.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -10).isActive = true
    }
    
    // MARK: Author Label
    private func setupAuthorLabel() {
        author.text = "저자: -"
        author.textColor = UIColor(named: "blight_gray")
        author.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(author)
        
        author.translatesAutoresizingMaskIntoConstraints = false
        author.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 12).isActive = true
        author.leadingAnchor.constraint(equalTo: title.leadingAnchor).isActive = true
        author.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -10).isActive = true
    }
    
    // MARK: Publish Date Label
    private func setupPublishDateLabel() {
        publishDate.text = "출간일: -"
        publishDate.textColor = UIColor(named: "blight_gray")
        publishDate.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(publishDate)
        
        publishDate.translatesAutoresizingMaskIntoConstraints = false
        publishDate.topAnchor.constraint(equalTo: author.bottomAnchor, constant: 6).isActive = true
        publishDate.leadingAnchor.constraint(equalTo: author.leadingAnchor).isActive = true
        publishDate.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -10).isActive = true
        publishDate.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
    }
    
    // MARK: ImageView
    private func setupImageView() {
        imageView.image = UIImage(named: "empty_image")
        imageView.contentMode = .scaleAspectFit
        self.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: title.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: publishDate.bottomAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        imageView.trailingAnchor.constraint(equalTo: title.leadingAnchor, constant: -12).isActive = true
    }
}
