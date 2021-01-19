//
//  RecentSearchTableCell.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/19.
//

import UIKit

class RecentSearchTableCell: UITableViewCell {
    static let identifier: String = "RecentSearchTableCell"
    let label = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.backgroundColor = UIColor(named: "deep_gray")?.withAlphaComponent(0)
        self.backgroundColor = UIColor(named: "deep_gray")?.withAlphaComponent(0.8)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        label.text = ""
        label.textColor = UIColor(named: "light_gray_blue")
        label.font = UIFont.systemFont(ofSize: 16)
        self.contentView.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8).isActive = true
        label.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8).isActive = true
        label.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16).isActive = true
        label.trailingAnchor.constraint(greaterThanOrEqualTo: self.contentView.trailingAnchor, constant: -4).isActive = true
    }
    
    func setupCellInformation(value: String) {
        label.text = value
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
