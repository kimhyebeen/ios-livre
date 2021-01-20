//
//  DetailViewController+UI.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/20.
//

import UIKit

extension DetailViewController {
    func setupHomeIcon() {
        self.view.addSubview(homeIcon)
        
        homeIcon.translatesAutoresizingMaskIntoConstraints = false
        homeIcon.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10).isActive = true
        homeIcon.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: -30).isActive = true
        
        setupButtonOnHomeIcon()
    }
    
    private func setupButtonOnHomeIcon() {
        let button = UIButton()
        button.addTarget(self, action: #selector(clickHomeIcon(_:)), for: .touchUpInside)
        self.view.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: homeIcon.topAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: homeIcon.bottomAnchor).isActive = true
        button.leadingAnchor.constraint(equalTo: homeIcon.leadingAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: homeIcon.trailingAnchor).isActive = true
    }
}
