//
//  MoreButtonTableCell.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/22.
//

import UIKit

class MoreButtonTableCell: UITableViewCell {
    static let identifier = "MoreButtonTableCell"
    let label = UILabel()
        .then {
            $0.text = "더보기"
            $0.textColor = .systemBlue
            $0.font = UIFont.boldSystemFont(ofSize: 17)
        }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        setupLabel()
    }
    
    private func setupLabel() {
        self.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: self.topAnchor, constant: 12).isActive = true
        label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12).isActive = true
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
}
