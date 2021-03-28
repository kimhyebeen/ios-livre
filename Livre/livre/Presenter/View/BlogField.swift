//
//  BlogField.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/20.
//

import UIKit
import RxSwift

class BlogField: UIView {
    let divider = UIView()
    let moreInformationButtonView = MoreInformationButtonView()
    let moreBlogButton = UIButton()
    let title = UILabel()
    let tableView = UITableView()
    
    var blogs: [BlogItem] = []
    private let disposeBag = DisposeBag()

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

extension BlogField {
    // MARK: Divider
    private func setupDivider() {
        divider.backgroundColor = .systemGray
        self.addSubview(divider)
        
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        divider.topAnchor.constraint(equalTo: self.topAnchor, constant: 45).isActive = true
        divider.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        divider.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
    }
    
    // MARK: Title Label
    private func setupTitleLabel() {
        title.text = "블로그 후기"
        title.textColor = UIColor(named: "coral")
        title.fontMontserratMedium(19)
        self.addSubview(title)
        
        title.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.top).offset(22.5)
            make.leading.equalToSuperview().offset(15)
        }
    }
    
    // MARK: More Blog Button
    private func setupMoreBlogButton() {
        self.addSubview(moreBlogButton)
        
        moreBlogButton.snp.makeConstraints { make in
            make.width.equalTo(moreInformationButtonView.snp.width).offset(10)
            make.height.equalTo(moreInformationButtonView.snp.height).offset(20)
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    // MARK: More Information Button
    private func setupMoreInformationButtonView() {
        self.addSubview(moreInformationButtonView)
        
        moreInformationButtonView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
    
    // MARK: Blog Table View
    private func setupBlogTableView() {
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BlogTableCell.self, forCellReuseIdentifier: BlogTableCell.identifier)
        self.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(divider.snp.bottom)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
}

// MARK: +Delegate
extension BlogField: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blogs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BlogTableCell.identifier, for: indexPath) as? BlogTableCell else {
            let cell = BlogTableCell()
            cell.setBlogInformtaion(item: blogs[indexPath.row])
            cell.selectionStyle = .none
            return cell
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
