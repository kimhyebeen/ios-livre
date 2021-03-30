//
//  BookImageCell.swift
//  livre
//
//  Created by 김혜빈 on 2021/03/30.
//

import UIKit

class BookImageCell: UICollectionViewCell {
    static let identifier = "BookImageCell"
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
    
    func loadImage(link: String) {
        guard let url: URL = URL(string: link) else { return }
        guard let imageData: Data = try? Data(contentsOf: url) else { return }
        DispatchQueue.main.async {
            self.imageView.image = UIImage(data: imageData)
        }
    }
    
    func editingMode(_ status: Bool) {
        removeButton.isHidden = !status
    }
}

extension BookImageCell {
    // MARK: ImageView
    func setupImageView() {
        imageView.image = UIImage(named: "empty_image")
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = .clear
        imageView.layer.borderColor = UIColor(named: "blight_gray")!.cgColor
        imageView.layer.borderWidth = 1
        self.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(22.5)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview().offset(-22.5)
        }
    }
    
    // MARK: RemoveButton
    func setupRemoveButton() {
        removeButton.setImage(UIImage(named: "remove_button"), for: .normal)
        removeButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        removeButton.isHidden = true
        self.addSubview(removeButton)
        
        removeButton.snp.makeConstraints { make in
            make.width.equalTo(45)
            make.height.equalTo(45)
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
}
