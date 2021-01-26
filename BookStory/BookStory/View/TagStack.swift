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
        self.alignment = .trailing
        self.axis = .vertical
    }
    
    func addLabel(value: String) {
        let label = UILabel()
            .then {
                $0.text = "# \(value)"
                $0.textColor = UIColor(named: "coral")
                $0.font = UIFont(name: "GmarketSansTTFMedium", size: 18)
            }
        self.addArrangedSubview(label)
    }
}
