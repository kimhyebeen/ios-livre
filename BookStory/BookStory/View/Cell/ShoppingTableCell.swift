//
//  ShoppingTableCell.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/26.
//

import UIKit

class ShoppingTableCell: UITableViewCell {
    static let identifier = "ShoppingTableCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        setupImageView()
        setupPrice()
        setupMallName()
    }

    func setShoppingInformation(item: Shopping) {
        
    }
}

// MARK: +UI
extension ShoppingTableCell {
    func setupImageView() {
        
    }
    
    func setupPrice() {
        
    }
    
    func setupMallName() {
        
    }
}
