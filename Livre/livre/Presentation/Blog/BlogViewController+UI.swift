//
//  BlogListViewController+UI.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/22.
//

import UIKit

extension BlogViewController {
    // MARK: Bar View
    func setupBarView() {
        barView.backgroundColor = UIColor(named: "deep_gray")!.withAlphaComponent(0.5)
        barView.layer.cornerRadius = 2
        self.view.addSubview(barView)
        
        barView.snp.makeConstraints { make in
            make.width.equalTo(deviceWidth * 0.3)
            make.height.equalTo(4)
            make.top.equalToSuperview().offset(8)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: Title Label
    func setupTitleLabel() {
        titleLabel.textColor = UIColor(named: "coral")
        titleLabel.fontGmarketSansMedium(24)
        titleLabel.text = "\'\(word)\' "
        self.view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.leading.equalToSuperview().offset(15)
            make.trailing.lessThanOrEqualToSuperview().offset((resultLabel.frame.width + 15) * -1)
        }
    }
    
    // MARK: Result Label
    func setupResultLabel() {
        resultLabel.text = "검색결과"
        resultLabel.textColor = UIColor(named: "coral")
        resultLabel.fontGmarketSansMedium(20)
        self.view.addSubview(resultLabel)
        
        resultLabel.snp.makeConstraints { make in
            make.bottom.equalTo(titleLabel.snp.bottom)
            make.leading.equalTo(titleLabel.snp.trailing)
            make.trailing.lessThanOrEqualToSuperview().offset(-15)
        }
    }
    
    // MARK: Table View
    func setupTableView() {
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(BlogTableCell.self, forCellReuseIdentifier: BlogTableCell.identifier)
        tableView.register(MoreButtonTableCell.self, forCellReuseIdentifier: MoreButtonTableCell.identifier)
        self.view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.bottom.equalToSuperview().offset(-40)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
        }
    }
}
