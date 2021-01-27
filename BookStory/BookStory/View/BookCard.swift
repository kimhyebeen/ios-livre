//
//  BookCard.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/24.
//

import UIKit

class BookCard: UIView {
    let labelStack = UIStackView()
        .then {
            $0.alignment = .leading
            $0.axis = .vertical
            $0.spacing = 4
        }
    let titleLabel = UILabel()
        .then {
            $0.text = "책 제목"
            $0.textColor = UIColor(named: "pale_gray")
            $0.font = UIFont(name: "GmarketSansTTFMedium", size: 19)
            $0.numberOfLines = 0
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
    let price = UILabel()
        .then {
            $0.text = "0"
            $0.textColor = UIColor(named: "pale_gray")
            $0.font = UIFont.systemFont(ofSize: 19)
        }
    let imageView = UIImageView()
        .then {
            $0.image = UIImage(named: "empty_image")
            $0.contentMode = .scaleToFill
            $0.backgroundColor = UIColor(named: "pale_gray")
            $0.layer.borderColor = UIColor(named: "blight_gray")?.cgColor
            $0.layer.borderWidth = 1
        }
    let contents = UILabel()
        .then {
            $0.text = "(책 내용)"
            $0.textColor = UIColor(named: "blight_gray")
            $0.font = UIFont(name: "GmarketSansTTFMedium", size: 15)
            $0.numberOfLines = 0
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
        self.backgroundColor = UIColor(named: "dull_blue")
        self.layer.cornerRadius = 20
        self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner]
        
        setupLabelStack()
        setupImageView()
        setupContents()
    }
    
    func setBookInformation(item: Book) {
        titleLabel.text = item.title
        author.text = "저자: \(item.author)"
        publishDate.text = "출간일: \(item.publishDateString)"
        price.text = item.price
        contents.text = item.description
        
        loadImage(link: item.image)
    }
    
    private func loadImage(link: String) {
        DispatchQueue.global().async {
            guard let url: URL = URL(string: link) else { return }
            guard let imageData: Data = try? Data(contentsOf: url) else { return }
            
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: imageData)
            }
        }
    }

}

// MARK: +UI
extension BookCard {
    func setupLabelStack() {
        labelStack.addArrangedSubview(titleLabel)
        labelStack.addArrangedSubview(author)
        labelStack.addArrangedSubview(publishDate)
        labelStack.addArrangedSubview(price)
        self.addSubview(labelStack)
        
        labelStack.translatesAutoresizingMaskIntoConstraints = false
        labelStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        labelStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: (UIScreen.main.bounds.width - 40) * 0.4).isActive = true
        labelStack.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -10).isActive = true
    }
    
    func setupImageView() {
        self.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 40) * 0.33).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 40) * 0.44).isActive = true
        imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: -15).isActive = true
        imageView.centerXAnchor.constraint(equalTo: self.leadingAnchor, constant: (UIScreen.main.bounds.width - 40) * 0.2).isActive = true
    }
    
    func setupContents() {
        self.addSubview(contents)
        
        contents.translatesAutoresizingMaskIntoConstraints = false
        contents.setContentHuggingPriority(UILayoutPriority(450), for: .vertical)
        let topWithImage = contents.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15)
        let topWithLabel = contents.topAnchor.constraint(equalTo: labelStack.bottomAnchor, constant: 15)
        topWithImage.priority = UILayoutPriority(450)
        topWithLabel.priority = UILayoutPriority(500)
        topWithImage.isActive = true
        topWithLabel.isActive = true
        contents.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        contents.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        contents.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
    }
}
