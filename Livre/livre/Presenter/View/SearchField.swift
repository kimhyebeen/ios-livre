//
//  SearchField.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/18.
//

import UIKit

class SearchField: UIView {
    let textfield = UITextField()
    let button = UIButton()
    private let spaceForTopBottom: CGFloat = 8
    private let buttonSize: CGFloat = 45
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
    }
    
    func setupView() {
        setupButton()
        setupTextField()
    }
    
    func setupButton() {
        button.setImage(UIImage(named: "search"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.addSubview(button)
        
        button.snp.makeConstraints { make in
            make.width.equalTo(buttonSize)
            make.height.equalTo(buttonSize)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    func setupTextField() {
        textfield.placeholder = "검색어를 입력해주세요"
        textfield.textColor = UIColor(named: "deep_gray")
        self.addSubview(textfield)
        
        textfield.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(spaceForTopBottom)
            make.bottom.equalToSuperview().offset(spaceForTopBottom * -1)
            make.leading.equalToSuperview().offset(spaceForTopBottom * 2)
            make.trailing.equalTo(button.snp.leading)
        }
    }
    
}
