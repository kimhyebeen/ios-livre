//
//  BookCardCell.swift
//  livre
//
//  Created by 김혜빈 on 2021/03/28.
//

import UIKit
import RxSwift

class BookCardCell: UICollectionViewCell {
    static let identifier = "BookCardCell"
    let bookCard = BookCard()
    let blogField = BlogField()
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
        self.backgroundColor = .clear
        
        setupBookCard()
        setupBlogField()
    }
    
    func setBookInformation(item: Book) {
        DispatchQueue.main.async { [weak self] in
            self?.bookCard.tagStack.removeLabels()
            self?.bookCard.setBookInformation(item: item)
        }
        requestKeywordList(item.contentsString)
        requestBlogItems(query: "책 \(item.titleString) 후기")
    }
    
    private func requestKeywordList(_ description: String) {
        requestKeywords(body: KeywordRequestBody(argument: KeywordRequestArgument(question: description)))
            .take(3)
            .subscribe(onNext: { [weak self] item in
                self?.bookCard.tagStack.addLabel(value: item)
            }).disposed(by: disposeBag)
    }
    
    private func requestBlogItems(query: String) {
        requestBlogs(query: query).subscribe(onNext: { [weak self] items in
            self?.blogField.setTableViewItem(items: items)
        }).disposed(by: disposeBag)
    }
}

extension BookCardCell {
    // MARK: BookCard
    private func setupBookCard() {
        self.addSubview(bookCard)
        
        bookCard.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.4)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
        }
    }
    
    // MARK: BlogField
    private func setupBlogField() {
        self.addSubview(blogField)
        
        blogField.snp.makeConstraints { make in
            make.top.equalTo(bookCard.snp.bottom).offset(30)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
}
