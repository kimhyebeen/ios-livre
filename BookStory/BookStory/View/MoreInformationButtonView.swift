//
//  MoreInformationButtonView.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/20.
//

import UIKit

class MoreInformationButtonView: UIView {
    let title = UILabel()
        .then {
            $0.text = "더보기"
            $0.textColor = UIColor(named: "deep_gray")
            $0.font = UIFont.systemFont(ofSize: 14)
        }
    let imageView = UIImageView()
        .then {
            $0.image = UIImage(named: "arrow_right")
        }

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
        self.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    private func setupTitleLabel() {
        self.addSubview(title)
        
        title.translatesAutoresizingMaskIntoConstraints = false
        title.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
        title.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        title.trailingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
    }

}
