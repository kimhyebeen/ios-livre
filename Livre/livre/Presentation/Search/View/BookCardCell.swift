//
//  BookCardCell.swift
//  livre
//
//  Created by 김혜빈 on 2021/03/28.
//

import UIKit
import RxSwift

protocol BookCardDelegate: class {
    func insertOrDeleteBook(_ status: Bool,_ book: Book?)
    func getKeywords(_ description: String) -> [String]
    func isExistInFavorite(_ title: String) -> Bool
}

class BookCardCell: UICollectionViewCell {
    static let identifier = "BookCardCell"
    let imageView = UIImageView()
    let labelStack = UIStackView()
    let titleLabel = UILabel()
    let authorLabel = UILabel()
    let publishDateLabel = UILabel()
    let priceLabel = UILabel()
    let favoriteButton = UIButton()
    let tagStack = TagStack()
    let contentsLabel = UILabel()
    
    let imageWidth: CGFloat = 102
    private let disposeBag = DisposeBag()
    
    weak var delegate: BookCardDelegate?
    var currentBook: Book? = nil
    
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
        setupFavoriteButton()
        setupTagStack()
        setupContentsLabel()
    }
    
    func setBookInformation(item: Book) {
        currentBook = item
        tagStack.removeLabels()
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.titleLabel.text = item.titleString
            self.authorLabel.text = item.authorString
            self.publishDateLabel.text = item.publishDateString
            self.priceLabel.text = item.price
            self.contentsLabel.text = item.contentsString
            
            self.loadImage(link: item.image)
        }
        
        checkFavorite()
        
        delegate?.getKeywords(item.contentsString).forEach {
            tagStack.addLabel(value: $0)
        }
    }
    
    private func loadImage(link: String) {
        guard let url: URL = URL(string: link) else { return }
        guard let imageData: Data = try? Data(contentsOf: url) else { return }
        DispatchQueue.main.async { [weak self] in
            self?.imageView.image = UIImage(data: imageData)
        }
    }
    
    private func checkFavorite() {
        guard let title = currentBook?.titleString else { return }
        guard let result = delegate?.isExistInFavorite(title) else { return }
        favoriteButton.isSelected = result
    }
    
    @objc func clickFavoriteButton(_ sender: UIButton) {
        favoriteButton.isSelected = !favoriteButton.isSelected
        let selected = favoriteButton.isSelected
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.delegate?.insertOrDeleteBook(selected, self.currentBook)
        }
    }
}

extension BookCardCell {
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
    
    // MARK: FavoriteButton
    private func setupFavoriteButton() {
        favoriteButton.setImage(UIImage(named: "favorite_normal"), for: .normal)
        favoriteButton.setImage(UIImage(named: "favorite_selected"), for: .selected)
        favoriteButton.imageEdgeInsets = UIEdgeInsets(top: 4.5, left: 4.5, bottom: 4.5, right: 4.5)
        favoriteButton.addTarget(self, action: #selector(clickFavoriteButton(_:)), for: .touchUpInside)
        self.addSubview(favoriteButton)
        
        favoriteButton.snp.makeConstraints { make in
            make.width.equalTo(45)
            make.height.equalTo(45)
            make.bottom.equalTo(imageView.snp.bottom).offset(10)
            make.trailing.equalToSuperview().offset(-6)
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
