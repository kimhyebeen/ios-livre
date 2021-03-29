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
    private let disposeBag = DisposeBag()
    
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
    }
    
    func setBookInformation(item: Book) {
        DispatchQueue.main.async { [weak self] in
            self?.bookCard.tagStack.removeLabels()
            self?.bookCard.setBookInformation(item: item)
        }
        requestKeywordList(item.contentsString)
    }
    
    private func requestKeywordList(_ description: String) {
        requestKeywords(body: KeywordRequestBody(argument: KeywordRequestArgument(question: description)))
            .take(3)
            .subscribe(onNext: { [weak self] item in
                self?.bookCard.tagStack.addLabel(value: item)
            }).disposed(by: disposeBag)
    }
}

extension BookCardCell {
    // MARK: BookCard
    private func setupBookCard() {
        self.addSubview(bookCard)
        
        bookCard.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
        }
    }
}
