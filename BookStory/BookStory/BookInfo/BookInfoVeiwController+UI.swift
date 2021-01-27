//
//  BookInfoVeiwController+UI.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/24.
//

import UIKit

extension BookInfoViewController {
    func setupBackground() {
        let bg = UIImageView()
            .then {
                $0.image = UIImage(named: "bg_book")
                $0.contentMode = .scaleToFill
            }
        self.view.addSubview(bg)
        
        bg.translatesAutoresizingMaskIntoConstraints = false
        bg.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        bg.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        bg.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        bg.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
    
    func setupBackButton() {
        backButton.addTarget(self, action: #selector(clickBackButton(_:)), for: .touchUpInside)
        self.view.addSubview(backButton)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.widthAnchor.constraint(equalToConstant: 45).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        backButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        backButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 7).isActive = true
    }
    
    func setupTagView() {
        self.view.addSubview(tagView)
        
        tagView.translatesAutoresizingMaskIntoConstraints = false
        tagView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        tagView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
    }
    
    func setupBookCard() {
        self.view.addSubview(bookCard)
        
        bookCard.translatesAutoresizingMaskIntoConstraints = false
        bookCard.topAnchor.constraint(equalTo: tagView.bottomAnchor, constant: 35).isActive = true
        bookCard.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        bookCard.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
    }
    
    func setupShoppingCollectionView() {
        shoppingCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: flowLayout)
            .then {
                $0.register(ShoppingCollectionCell.self, forCellWithReuseIdentifier: ShoppingCollectionCell.identifier)
                $0.delegate = self
                $0.dataSource = self
                $0.backgroundColor = UIColor(named: "pale_gray")
            }
        self.view.addSubview(shoppingCollectionView)
        
        shoppingCollectionView.translatesAutoresizingMaskIntoConstraints = false
        shoppingCollectionView.topAnchor.constraint(equalTo: bookCard.bottomAnchor, constant: 20).isActive = true
        shoppingCollectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        shoppingCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        shoppingCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
    }
}