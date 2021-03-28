//
//  ShoppingTableCell.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/26.
//

import UIKit

class ShoppingCollectionCell: UICollectionViewCell {
    static let identifier = "ShoppingCollectionCell"
    let price = UILabel()
    let mall = UILabel()
    let icon = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
    }
    
    private func setupView() {
        self.backgroundColor = UIColor(named: "dull_blue")?.withAlphaComponent(0.2)
        self.layer.cornerRadius = 17
        
        setupIcon()
        setupPrice()
        setupMallName()
    }

    func setShoppingInformation(item: Shopping) {
        price.text = item.price
        mall.text = item.mallName
    }
}

extension ShoppingCollectionCell {
    // MARK: Price Label
    func setupPrice() {
        price.text = "0"
        price.textColor = UIColor(named: "deep_gray")
        price.fontGmarketSansLight(22)
        self.addSubview(price)
        
        price.translatesAutoresizingMaskIntoConstraints = false
        price.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        price.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12).isActive = true
    }
    
    // MARK: Mall Name Label
    func setupMallName() {
        mall.text = "쇼핑몰 이름"
        mall.textColor = UIColor(named: "deep_gray")?.withAlphaComponent(0.7)
        mall.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(mall)
        
        mall.translatesAutoresizingMaskIntoConstraints = false
        mall.topAnchor.constraint(equalTo: price.bottomAnchor, constant: 4).isActive = true
        mall.leadingAnchor.constraint(equalTo: price.leadingAnchor).isActive = true
        mall.trailingAnchor.constraint(lessThanOrEqualTo: icon.leadingAnchor, constant: -4).isActive = true
    }
    
    // MARK: Icon
    func setupIcon() {
        icon.image = UIImage(named: "arrow_right")
        self.addSubview(icon)
        
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.widthAnchor.constraint(equalToConstant: 24).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 24).isActive = true
        icon.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        icon.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -6).isActive = true
    }
}
