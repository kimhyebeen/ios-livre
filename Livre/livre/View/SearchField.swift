//
//  SearchField.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/18.
//

import UIKit

class SearchField: UIView {
    let textfield = UITextField()
        .then {
            $0.placeholder = "검색어를 입력해주세요"
            $0.textColor = UIColor(named: "deep_gray")
        }
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
        self.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: buttonSize).isActive = true
        button.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func setupTextField() {
        self.addSubview(textfield)
        
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.topAnchor.constraint(equalTo: self.topAnchor, constant: spaceForTopBottom).isActive = true
        textfield.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: spaceForTopBottom * -1).isActive = true
        textfield.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: spaceForTopBottom * 2).isActive = true
        textfield.trailingAnchor.constraint(equalTo: button.leadingAnchor).isActive = true
    }
    
}
