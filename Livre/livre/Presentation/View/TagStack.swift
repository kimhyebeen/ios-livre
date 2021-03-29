//
//  BookInfoTagStack.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/24.
//

import UIKit

class TagStack: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
    }
    
    private func setupView() {
        self.spacing = 4
        self.alignment = .center
        self.distribution = .equalSpacing
        self.axis = .horizontal
    }
    
    func addLabel(value: String) {
        let label = UILabel()
        label.text = "# \(value)"
        label.textColor = UIColor(named: "apricot")
        label.fontGmarketSansMedium(13)
        self.addArrangedSubview(label)
    }
    
    func removeLabels() {
        for item in self.arrangedSubviews {
            item.removeFromSuperview()
        }
    }
}
