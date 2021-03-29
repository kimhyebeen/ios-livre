//
//  BookCard.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/24.
//

import UIKit
import RxSwift

class BookCard: UIView {
    let imageView = UIImageView()
    let labelStack = UIStackView()
    let titleLabel = UILabel()
    let authorLabel = UILabel()
    let publishDateLabel = UILabel()
    let priceLabel = UILabel()
    let tagStack = TagStack()
    let contentsLabel = UILabel()
    
    let imageWidth: CGFloat = 102
    let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
    }
    
    private func setupView() {
        self.backgroundColor = UIColor(named: "book_card")
        self.layer.cornerRadius = 20
        self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner]
        
        setupLabelStack()
        setupImageView()
        setupTagStack()
        setupContentsLabel()
    }
    
    func setKeywords(item: String) {
        tagStack.addLabel(value: item)
    }
    
    func setBookInformation(item: Book) {
        titleLabel.text = item.titleString
        authorLabel.text = item.author
        publishDateLabel.text = item.publishDateString
        priceLabel.text = item.price
        contentsLabel.text = item.contentsString
        
        loadImage(link: item.image)
    }
    
    private func loadImage(link: String) {
        guard let url: URL = URL(string: link) else { return }
        guard let imageData: Data = try? Data(contentsOf: url) else { return }
        DispatchQueue.main.async {
            self.imageView.image = UIImage(data: imageData)
        }
    }
}

extension BookCard {
    // MARK: Label Stack
    private func setupLabelStack() {
        setupTitleLabel()
        setupAuthorLabel()
        setupPublishDateLabel()
        setupPriceLabel()
        
        labelStack.alignment = .leading
        labelStack.axis = .vertical
        labelStack.spacing = 4
        labelStack.addArrangedSubview(titleLabel)
        labelStack.addArrangedSubview(authorLabel)
        labelStack.addArrangedSubview(publishDateLabel)
        labelStack.addArrangedSubview(priceLabel)
        self.addSubview(labelStack)
        
        labelStack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(imageWidth + 20)
            make.trailing.lessThanOrEqualToSuperview().offset(-10)
        }
    }
    
    // MARK: Title Label
    private func setupTitleLabel() {
        titleLabel.text = "책 제목"
        titleLabel.textColor = UIColor(named: "book_card_label")!
        titleLabel.fontGmarketSansMedium(19)
        titleLabel.numberOfLines = 2
    }
    
    // MARK: Author Label
    private func setupAuthorLabel() {
        authorLabel.text = "저자"
        authorLabel.textColor = UIColor(named: "book_card_label")!
        authorLabel.font = .systemFont(ofSize: 14)
    }
    
    // MARK: Publish Date Label
    private func setupPublishDateLabel() {
        publishDateLabel.text = "출간일"
        publishDateLabel.textColor = UIColor(named: "book_card_label")!
        publishDateLabel.font = .systemFont(ofSize: 14)
    }
    
    // MARK: Price Label
    private func setupPriceLabel() {
        priceLabel.text = "가격"
        priceLabel.textColor = UIColor(named: "book_card_label")!
        priceLabel.font = .systemFont(ofSize: 19)
    }
    
    // MARK: ImageView
    private func setupImageView() {
        imageView.image = UIImage(named: "empty_image")
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = .clear
        imageView.layer.borderColor = UIColor(named: "blight_gray")!.cgColor
        imageView.layer.borderWidth = 1
        
        self.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.width.equalTo(imageWidth)
            make.height.equalTo(imageWidth / 3 * 4)
            make.top.equalToSuperview().offset(-15)
            make.leading.equalToSuperview().offset(10)
        }
    }
    
    // MARK: TagStack
    private func setupTagStack() {
        self.addSubview(tagStack)
        
        tagStack.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
        }
    }
    
    // MARK: Contents Label
    private func setupContentsLabel() {
        contentsLabel.text = "(책 내용)"
        contentsLabel.textColor = UIColor(named: "book_card_label")
        contentsLabel.fontGmarketSansMedium(15)
        contentsLabel.numberOfLines = 0
        self.addSubview(contentsLabel)
        
        contentsLabel.snp.makeConstraints { make in
            make.top.equalTo(tagStack.snp.bottom).offset(10)
            make.bottom.lessThanOrEqualToSuperview().offset(-20)
            make.leading.equalToSuperview().offset(15)
            make.trailing.lessThanOrEqualToSuperview().offset(-15)
        }
    }
}
