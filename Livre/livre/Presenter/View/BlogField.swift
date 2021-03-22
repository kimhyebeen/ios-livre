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
            $0.textColor = UIColor(named: "coral")
            $0.font = UIFont(name: "Montserrat-Medium", size: 20)
        }
    let tableView = UITableView()
        .then {
            $0.backgroundColor = UIColor.white.withAlphaComponent(0)
            $0.separatorColor = UIColor.systemGray
        }
    
    var blogs: [BlogItem] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
    }
    
    private func setupView() {
        self.setRoundedRectangle(radius: 15)
        self.backgroundColor = UIColor(named: "pale_gray")?.withAlphaComponent(0.9)
        
        setupDivider()
        setupTitleLabel()
        setupMoreInformationButtonView()
        setupMoreBlogButton()
        setupBlogTableView()
    }
    
    func setTableViewItem(items: [BlogItem]) {
        blogs = items
        tableView.reloadData()
    }
    
    func moveToFirstRow() {
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }

}

// MARK: +UI
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
        self.addSubview(moreBlogButton)
        
        moreBlogButton.translatesAutoresizingMaskIntoConstraints = false
        moreBlogButton.widthAnchor.constraint(equalTo: moreInformationButtonView.widthAnchor, constant: 10).isActive = true
        moreBlogButton.heightAnchor.constraint(equalTo: moreInformationButtonView.heightAnchor, constant: 20).isActive = true
        moreBlogButton.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        moreBlogButton.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    private func setupMoreInformationButtonView() {
        self.addSubview(moreInformationButtonView)
        
        moreInformationButtonView.translatesAutoresizingMaskIntoConstraints = false
        moreInformationButtonView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        moreInformationButtonView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
    }
    
    private func setupBlogTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BlogTableCell.self, forCellReuseIdentifier: BlogTableCell.identifier)
        self.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: divider.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
}

// MARK: +Delegate
extension BlogField: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blogs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BlogTableCell.identifier, for: indexPath) as? BlogTableCell else {
            return BlogTableCell().then {
                $0.setBlogInformtaion(item: blogs[indexPath.row])
                $0.selectionStyle = .none
            }
        }
        
        cell.setBlogInformtaion(item: blogs[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        guard let url = URL(string: blogs[indexPath.row].link) else { return indexPath }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            print("BlogField - 블로그 url에 연결하지 못했습니다.")
        }
        
        return indexPath
    }
}