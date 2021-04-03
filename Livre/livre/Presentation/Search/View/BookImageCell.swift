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
    let removeImage = UIImageView()
    
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
        removeImage.isHidden = !status
    }
}

extension BookImageCell {
    // MARK: ImageView
    func setupImageView() {
        imageView.image = UIImage(named: "empty_image")
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = UIColor(named: "pale_gray")!
        imageView.layer.borderColor = UIColor(named: "blight_gray")!.cgColor
        imageView.layer.borderWidth = 1
        self.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    // MARK: RemoveButton
    func setupRemoveButton() {
        removeImage.image = UIImage(named: "remove_button")
        removeImage.alpha = 0.6
        removeImage.isHidden = true
        self.addSubview(removeImage)
        
        removeImage.snp.makeConstraints { make in
            make.width.equalTo(24)
            make.height.equalTo(24)
            make.center.equalToSuperview()
        }
    }
}
