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
        label.text = "더보기"
        label.textColor = .systemBlue
        label.font = UIFont.boldSystemFont(ofSize: 17)
        self.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.bottom.equalToSuperview().offset(-12)
            make.centerX.equalToSuperview()
        }
    }
}
