//
//  BookCard.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/24.
//

import UIKit

class BookCard: UIView {
    let hole = UIView()
        .then {
            $0.backgroundColor = UIColor(named: "pale_gray")
            $0.frame.size = CGSize(width: 24, height: 24)
            $0.layer.cornerRadius = 12
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
        self.backgroundColor = UIColor(named: "soft_navy")
        self.layer.cornerRadius = 15
        
        setupHole()
    }

}

// MARK: +UI
extension BookCard {
    func setupHole() {
        self.addSubview(hole)
        
        hole.translatesAutoresizingMaskIntoConstraints = false
        hole.widthAnchor.constraint(equalToConstant: 24).isActive = true
        hole.heightAnchor.constraint(equalToConstant: 24).isActive = true
        hole.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        hole.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
    }
}
