//
//  BlogListViewController.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/21.
//

import UIKit

class BlogListViewController: UIViewController {
    let deviceWidth = UIScreen.main.bounds.width
    let deviceHeight = UIScreen.main.bounds.height
    var word: String = ""
    
    let barView = UIView()
        .then {
            $0.backgroundColor = UIColor(named: "pale_gray")
            $0.layer.cornerRadius = 2
        }
    let titleLabel = UILabel()
        .then {
            $0.textColor = UIColor(named: "deep_gray")
            $0.font = UIFont(name: "GmarketSansTTFMedium", size: 24)
        }
    let resultLabel = UILabel()
        .then {
            $0.textColor = UIColor(named: "deep_gray")
            $0.font = UIFont(name: "GmarketSansTTFMedium", size: 20)
            $0.text = "검색결과"
        }
    let tableView = UITableView()
    
    var blogs: [BlogItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        let blurEffect = UIBlurEffect(style: .regular)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.frame = self.view.frame
        self.view.addSubview(visualEffectView)
        
        setupBarView()
        setupTitleLabel()
        setupResultLabel()
        setupTableView()
    }
}

// MARK: +Delegate
extension BlogListViewController: UITableViewDataSource, UITableViewDelegate {
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
            print("BlogListViewController - 블로그 url에 연결하지 못했습니다.")
        }

        return indexPath
    }
}
