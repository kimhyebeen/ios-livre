//
//  BlogListViewController+UI.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/22.
//

import Foundation

extension BlogListViewController {
    // MARK: Bar View
    func setupBarView() {
        self.view.addSubview(barView)
        
        barView.translatesAutoresizingMaskIntoConstraints = false
        barView.widthAnchor.constraint(equalToConstant: deviceWidth * 0.3).isActive = true
        barView.heightAnchor.constraint(equalToConstant: 4).isActive = true
        barView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 8).isActive = true
        barView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    // MARK: Title Label
    func setupTitleLabel() {
        titleLabel.text = "\'\(word)\' "
        self.view.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15).isActive = true
        titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.view.trailingAnchor, constant: (resultLabel.frame.width + 15) * -1).isActive = true
    }
    
    // MARK: Result Label
    func setupResultLabel() {
        self.view.addSubview(resultLabel)
        
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        resultLabel.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        resultLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        resultLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.view.trailingAnchor, constant: -15).isActive = true
    }
    
    // MARK: Table View
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(BlogTableCell.self, forCellReuseIdentifier: BlogTableCell.identifier)
        tableView.register(MoreButtonTableCell.self, forCellReuseIdentifier: MoreButtonTableCell.identifier)
        self.view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -40).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15).isActive = true
    }
}
