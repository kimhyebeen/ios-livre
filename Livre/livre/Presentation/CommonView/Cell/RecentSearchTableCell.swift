//
//  RecentSearchTableCell.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/19.
//

import UIKit

class RecentSearchTableCell: UITableViewCell {
    static let identifier: String = "RecentSearchTableCell"
    private let label = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.selectionStyle = .none
        self.contentView.backgroundColor = UIColor(named: "deep_gray")?.withAlphaComponent(0)
        self.backgroundColor = UIColor(named: "deep_gray")?.withAlphaComponent(0.8)
        
        setupLabel()
    }
    
    private func setupLabel() {
        label.text = ""
        label.textColor = UIColor(named: "light_gray_blue")
        label.font = UIFont.systemFont(ofSize: 16)
        self.contentView.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.top.equalTo(self.contentView.snp.top).offset(8)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-8)
            make.leading.equalTo(self.contentView.snp.leading).offset(16)
            make.trailing.greaterThanOrEqualTo(self.contentView.snp.trailing).offset(-4)
        }
    }
    
    func setupCellInformation(value: String) {
        label.text = value
    }

}
