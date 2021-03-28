//
//  MoreInformationButtonView.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/20.
//

import UIKit

class MoreInformationButtonView: UIView {
    let title = UILabel()
    let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
    }
    
    private func setupView() {
        setupImageView()
        setupTitleLabel()
    }
    
    private func setupImageView() {
        imageView.image = UIImage(named: "arrow_right")
        self.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    private func setupTitleLabel() {
        title.text = "더보기"
        title.textColor = UIColor(named: "deep_gray")
        title.font = UIFont(name: "NotoSansKR-Medium", size: 15)
        self.addSubview(title)
        
        title.translatesAutoresizingMaskIntoConstraints = false
        title.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
        title.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        title.trailingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
    }

}
