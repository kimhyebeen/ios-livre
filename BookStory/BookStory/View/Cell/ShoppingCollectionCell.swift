//
//  ShoppingTableCell.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/26.
//

import UIKit

class ShoppingCollectionCell: UICollectionViewCell {
    static let identifier = "ShoppingCollectionCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
    }
    
    private func setupView() {
        self.backgroundColor = .yellow
        
        setupPrice()
        setupMallName()
    }

    func setShoppingInformation(item: Shopping) {
        
    }
}

// MARK: +UI
extension ShoppingCollectionCell {
    func setupPrice() {
        
    }
    
    func setupMallName() {
        
    }
}
