//
//  NewsField.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/20.
//

import UIKit

class NewsField: UIView {
    let title = UILabel()
        .then {
            $0.text = "NEWS"
            $0.textColor = UIColor(named: "coral")
            $0.font = UIFont.boldSystemFont(ofSize: 17)
        }
    let divider = UIView()
        .then {
            $0.backgroundColor = .systemGray
        }
    let moreInformationButtonView = MoreInformationButtonView()
    let moreNewsButton = UIButton()
    let tableView = UITableView()
        .then {
            $0.backgroundColor = UIColor.white.withAlphaComponent(0)
        }
    
    var news: [NewsItem] = []

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
        
        setupTitleLabel()
        setupDivider()
        setupMoreNewsButton()
        setupTableView()
    }
    
    func setTableViewItem(items: [NewsItem]) {
        news = items
        tableView.reloadData()
    }

}

// MARK: +UI
extension NewsField {
    private func setupTitleLabel() {
        self.addSubview(title)
        
        title.translatesAutoresizingMaskIntoConstraints = false
        title.centerYAnchor.constraint(equalTo: self.topAnchor, constant: 22.5).isActive = true
        title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
    }
    
    private func setupDivider() {
        self.addSubview(divider)
        
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        divider.topAnchor.constraint(equalTo: self.topAnchor, constant: 45).isActive = true
        divider.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        divider.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
    }
    
    private func setupMoreNewsButton() {
        setupMoreInformationButtonView()
        self.addSubview(moreNewsButton)
        
        moreNewsButton.translatesAutoresizingMaskIntoConstraints = false
        moreNewsButton.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        moreNewsButton.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    private func setupMoreInformationButtonView() {
        moreNewsButton.addSubview(moreInformationButtonView)
        
        moreInformationButtonView.translatesAutoresizingMaskIntoConstraints = false
        moreInformationButtonView.topAnchor.constraint(equalTo: moreNewsButton.topAnchor, constant: 10).isActive = true
        moreInformationButtonView.bottomAnchor.constraint(equalTo: moreNewsButton.bottomAnchor, constant: -10).isActive = true
        moreInformationButtonView.leadingAnchor.constraint(equalTo: moreNewsButton.leadingAnchor).isActive = true
        moreInformationButtonView.trailingAnchor.constraint(equalTo: moreNewsButton.trailingAnchor, constant: -10).isActive = true
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsTableCell.self, forCellReuseIdentifier: NewsTableCell.identifier)
        self.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: divider.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
}

// MARK: +Delegate
extension NewsField: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableCell.identifier, for: indexPath) as? NewsTableCell else {
            return NewsTableCell()
        }
        
        cell.setNewsInformation(item: news[indexPath.row])
        return cell
    }
}
