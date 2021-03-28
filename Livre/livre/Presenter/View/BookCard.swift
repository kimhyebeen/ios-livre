//
//  BookCard.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/24.
//

import UIKit

class BookCard: UIView {
    let labelStack = UIStackView()
    let titleLabel = UILabel()
    let author = UILabel()
    let publishDate = UILabel()
    let price = UILabel()
    let imageView = UIImageView()
    let contents = UILabel()

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
        
        setupTitleLabel()
        setupAuthor()
        setupPublishDate()
        setupPrice()
        
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

extension BookCard {
    // MARK: Title Label
    private func setupTitleLabel() {
        titleLabel.text = "책 제목"
        titleLabel.textColor = UIColor(named: "pale_gray")
        titleLabel.font = UIFont(name: "GmarketSansTTFMedium", size: 19)
        titleLabel.numberOfLines = 0
    }
    
    // MARK: Author
    private func setupAuthor() {
        author.text = "저자: -"
        author.textColor = UIColor(named: "blight_gray")
        author.font = UIFont.systemFont(ofSize: 14)
    }
    
    // MARK: Publish Date
    private func setupPublishDate() {
        publishDate.text = "출간일: -"
        publishDate.textColor = UIColor(named: "blight_gray")
        publishDate.font = UIFont.systemFont(ofSize: 14)
    }
    
    // MARK: Price
    private func setupPrice() {
        price.text = "0"
        price.textColor = UIColor(named: "pale_gray")
        price.font = UIFont.systemFont(ofSize: 19)
    }
    
    // MARK: Label Stack
    private func setupLabelStack() {
        labelStack.alignment = .leading
        labelStack.axis = .vertical
        labelStack.spacing = 4
        labelStack.addArrangedSubview(titleLabel)
        labelStack.addArrangedSubview(author)
        labelStack.addArrangedSubview(publishDate)
        labelStack.addArrangedSubview(price)
        self.addSubview(labelStack)
        
        labelStack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset((UIScreen.main.bounds.width - 40) * 0.4)
            make.trailing.lessThanOrEqualToSuperview().offset(-10)
        }
    }
    
    // MARK: ImageView
    private func setupImageView() {
        imageView.image = UIImage(named: "empty_image")
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = UIColor(named: "pale_gray")
        imageView.layer.borderColor = UIColor(named: "blight_gray")?.cgColor
        imageView.layer.borderWidth = 1
        self.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.width.equalTo((UIScreen.main.bounds.width - 40) * 0.33)
            make.height.equalTo((UIScreen.main.bounds.width - 40) * 0.44)
            make.centerX.equalTo(self.snp.leading).offset((UIScreen.main.bounds.width - 40) * 0.2)
            make.top.equalToSuperview().offset(-15)
        }
    }
    
    // MARK: Contents
    private func setupContents() {
        contents.text = "(책 내용)"
        contents.textColor = UIColor(named: "blight_gray")
        contents.fontGmarketSansMedium(15)
        contents.numberOfLines = 0
        self.addSubview(contents)
        
        contents.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(15).priority(450)
            make.top.equalTo(labelStack.snp.bottom).offset(15).priority(500)
            make.bottom.equalToSuperview().offset(-20)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
        }
    }
}
