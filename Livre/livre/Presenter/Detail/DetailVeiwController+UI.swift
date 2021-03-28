//
//  BookInfoVeiwController+UI.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/24.
//

import UIKit

extension DetailViewController {
    // MARK: Background
    func setupBackground() {
        let bg = UIImageView()
        bg.image = UIImage(named: "bg_book")
        bg.contentMode = .scaleToFill
        self.view.addSubview(bg)
        
        bg.translatesAutoresizingMaskIntoConstraints = false
        bg.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        bg.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        bg.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        bg.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
    
    // MARK: Back Button
    func setupBackButton() {
        backButton.imageView?.frame.size = CGSize(width: 24, height: 24)
        backButton.imageView?.backgroundColor = UIColor(named: "pale_gray")
        backButton.imageView?.layer.cornerRadius = 12
        backButton.setImage(UIImage(named: "arrow_left"), for: .normal)
        backButton.imageEdgeInsets = UIEdgeInsets(top: 10.5, left: 10.5, bottom: 10.5, right: 10.5)
        backButton.addTarget(self, action: #selector(clickBackButton(_:)), for: .touchUpInside)
        self.view.addSubview(backButton)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.widthAnchor.constraint(equalToConstant: 45).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        backButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        backButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 7).isActive = true
    }
    
    // MARK: Tag View
    func setupTagView() {
        self.view.addSubview(tagView)
        
        tagView.translatesAutoresizingMaskIntoConstraints = false
        tagView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        tagView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
    }
    
    // MARK: Book Card
    func setupBookCard() {
        self.view.addSubview(bookCard)
        
        bookCard.translatesAutoresizingMaskIntoConstraints = false
        let topWithTag = bookCard.topAnchor.constraint(equalTo: tagView.bottomAnchor, constant: 35)
        let topWithView = bookCard.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60)
        topWithTag.priority = UILayoutPriority(500)
        topWithView.priority = UILayoutPriority(450)
        topWithTag.isActive = true
        topWithView.isActive = true
        bookCard.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        bookCard.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
    }
    
    // MARK: Shopping Collection View
    func setupShoppingCollectionView() {
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width * 0.43, height: 57)
        flowLayout.scrollDirection = .vertical
        shoppingCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: flowLayout)
        shoppingCollectionView.register(ShoppingCollectionCell.self, forCellWithReuseIdentifier: ShoppingCollectionCell.identifier)
        shoppingCollectionView.delegate = self
        shoppingCollectionView.dataSource = self
        shoppingCollectionView.backgroundColor = UIColor(named: "pale_gray")?.withAlphaComponent(0)
        self.view.addSubview(shoppingCollectionView)
        
        shoppingCollectionView.translatesAutoresizingMaskIntoConstraints = false
        shoppingCollectionView.topAnchor.constraint(equalTo: bookCard.bottomAnchor, constant: 20).isActive = true
        shoppingCollectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        shoppingCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        shoppingCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
    }
}
