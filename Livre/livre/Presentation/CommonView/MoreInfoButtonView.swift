//
//  MoreInformationButtonView.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/20.
//

import UIKit

class MoreInfoButtonView: UIView {
    let title = UILabel()
    let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        setupImageView()
        setupTitleLabel()
    }
    
    private func setupImageView() {
        imageView.image = UIImage(named: "arrow_right")
        self.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.width.equalTo(25)
            make.height.equalTo(25)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    private func setupTitleLabel() {
        title.text = "더보기"
        title.textColor = UIColor(named: "deep_gray")
        title.font = UIFont(name: "NotoSansKR-Medium", size: 15)
        self.addSubview(title)
        
        title.snp.makeConstraints { make in
            make.centerY.equalTo(imageView.snp.centerY)
            make.leading.equalToSuperview()
            make.trailing.equalTo(imageView.snp.leading)
        }
    }

}
