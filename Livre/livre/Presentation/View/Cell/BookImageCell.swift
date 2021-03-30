//
//  BookImageCell.swift
//  livre
//
//  Created by 김혜빈 on 2021/03/30.
//

import UIKit

class BookImageCell: UICollectionViewCell {
    let imageView = UIImageView()
    let removeButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        setupImageView()
        setupRemoveButton()
    }
}

extension BookImageCell {
    // MARK: ImageView
    func setupImageView() {
        
    }
    
    // MARK: RemoveButton
    func setupRemoveButton() {
        
    }
}
