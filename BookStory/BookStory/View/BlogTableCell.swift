//
//  BlogTableCell.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/20.
//

import UIKit

class BlogTableCell: UITableViewCell {
    static let identifier = "BlogTableCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.layer.cornerRadius = 10
        setupTitleLabel()
        setupPostDateLabel()
        setupDescriptionLabel()
        setupBloggerNameLabel()
    }
    
    func setBlogInformtaion(item: BlogItem) {
        
    }
}

extension BlogTableCell {
    private func setupTitleLabel() {
        
    }
    
    private func setupPostDateLabel() {
        
    }
    
    private func setupDescriptionLabel() {
        
    }
    
    private func setupBloggerNameLabel() {
        
    }
}
