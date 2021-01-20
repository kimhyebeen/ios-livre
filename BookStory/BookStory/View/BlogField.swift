//
//  BlogField.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/20.
//

import UIKit

class BlogField: UIView {
    let divider = UIView()
        .then {
            $0.backgroundColor = .systemGray
        }
    let moreInformationButtonView = MoreInformationButtonView()
    let moreBlogButton = UIButton()
    let title = UILabel()
        .then {
            $0.text = "BLOG"
            $0.textColor = UIColor(named: "navy")
            $0.font = UIFont.boldSystemFont(ofSize: 17)
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
        self.setRoundedRectangle(radius: 20)
        self.backgroundColor = UIColor(named: "pale_gray")
        
        setupDivider()
        setupTitleLabel()
        setupMoreBlogButton()
    }
    
    func setTableViewItem() {
        
    }

}

extension BlogField {
    private func setupDivider() {
        self.addSubview(divider)
        
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        divider.topAnchor.constraint(equalTo: self.topAnchor, constant: 45).isActive = true
        divider.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        divider.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
    }
    
    private func setupTitleLabel() {
        self.addSubview(title)
        
        title.translatesAutoresizingMaskIntoConstraints = false
        title.centerYAnchor.constraint(equalTo: self.topAnchor, constant: 22.5).isActive = true
        title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
    }
    
    private func setupMoreBlogButton() {
        setupMoreInformationButtonView()
        self.addSubview(moreBlogButton)
        
        moreBlogButton.translatesAutoresizingMaskIntoConstraints = false
        moreBlogButton.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        moreBlogButton.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    private func setupMoreInformationButtonView() {
        moreBlogButton.addSubview(moreInformationButtonView)
        
        moreInformationButtonView.translatesAutoresizingMaskIntoConstraints = false
        moreInformationButtonView.topAnchor.constraint(equalTo: moreBlogButton.topAnchor, constant: 10).isActive = true
        moreInformationButtonView.bottomAnchor.constraint(equalTo: moreBlogButton.bottomAnchor, constant: -10).isActive = true
        moreInformationButtonView.leadingAnchor.constraint(equalTo: moreBlogButton.leadingAnchor).isActive = true
        moreInformationButtonView.trailingAnchor.constraint(equalTo: moreBlogButton.trailingAnchor, constant: -10).isActive = true
    }
    
    private func setupBlogTableView() {
        
    }
}
