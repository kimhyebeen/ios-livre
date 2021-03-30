//
//  FavoriteCollectionField.swift
//  livre
//
//  Created by 김혜빈 on 2021/03/30.
//

import UIKit

class FavoriteCollectionField: UIView {
    private let emptyLabel = UILabel()
    private let flowLayout = UICollectionViewFlowLayout()
    private var collectionView: UICollectionView!
//    var vm: BookDataViewModel!
//    var items: [BookData] = []
    var isEditMode: Bool = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.backgroundColor = .clear
        setupEmptyLabel()
        setupFlowLayout()
        setupCollectionView()
    }
    
//    func setFavoriteItems(_ items: [BookData]) {
//        if items.count == 0 { emptyLabel.isHidden = false }
//        else { emptyLabel.isHidden = true }
//        collectionView.reloadData()
//    }
    
}

extension FavoriteCollectionField {
    func setupEmptyLabel() {
        emptyLabel.text = "즐겨찾는 책이 없어요 😂"
        emptyLabel.fontGmarketSansLight(14)
        emptyLabel.textColor = UIColor(named: "label_color")
        emptyLabel.isHidden = true
        self.addSubview(emptyLabel)
        
        emptyLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func setupFlowLayout() {
        flowLayout.itemSize = CGSize(width: 120 + 22.5, height: 160 + 22.5)
        flowLayout.scrollDirection = .horizontal
    }
    
    func setupCollectionView() {
        collectionView = UICollectionView(frame: self.frame, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset.left = 30
        collectionView.contentInset.right = 30
        collectionView.backgroundColor = .clear
        collectionView.decelerationRate = .normal
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(BookImageCell.self, forCellWithReuseIdentifier: BookImageCell.identifier)
        self.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
}

extension FavoriteCollectionField: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return items.count
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookImageCell.identifier, for: indexPath) as? BookImageCell else {
            return BookImageCell()
        }
        
//        cell.loadImage(link: items[indexPath.item].image)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if !isEditMode { return true }
        
//        vm.removeBookData(items[indexPath.item])
        return true
    }
    
}
