//
//  BlogListViewController.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/21.
//

import UIKit
import RxSwift

class BlogListViewController: BaseViewController {
    let deviceWidth = UIScreen.main.bounds.width
    let deviceHeight = UIScreen.main.bounds.height
    let disposeBag = DisposeBag()
    var word: String = ""
    var vm: BlogListViewModel!
    var blogs: [BlogItem] = []
    
    let barView = UIView()
    let titleLabel = UILabel()
    let resultLabel = UILabel()
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        vm = BlogListViewModel(word: word)
        setupView()
        bindViewModel()
    }
    
    private func setupView() {
        let blurEffect = UIBlurEffect(style: .light)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.frame = self.view.frame
        self.view.addSubview(visualEffectView)
        
        setupBarView()
        setupTitleLabel()
        setupResultLabel()
        setupTableView()
    }
    
    private func bindViewModel() {
        vm.blogs.subscribe(onNext: { [weak self] items in
            self?.blogs.append(contentsOf: items)
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)
    }
    
    func connectBlogUrl(url: URL) {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            print("BlogListViewController - 블로그 url에 연결하지 못했습니다.")
        }
    }
    
    func clickMoreRequestButton() {
        vm.requestBlogItems()
        tableView.reloadData()
    }
}

// MARK: +Delegate
extension BlogListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blogs.count+1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == blogs.count {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MoreButtonTableCell.identifier, for: indexPath) as? MoreButtonTableCell else {
                return MoreButtonTableCell()
            }
            
            cell.selectionStyle = .none
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BlogTableCell.identifier, for: indexPath) as? BlogTableCell else {
            let emptyCell = BlogTableCell()
            emptyCell.setBlogInformtaion(item: blogs[indexPath.row])
            emptyCell.selectionStyle = .none
            return emptyCell
        }
        
        cell.setBlogInformtaion(item: blogs[indexPath.row])
        cell.setLightMode()
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.row == blogs.count {
            self.clickMoreRequestButton()
            return indexPath
        }
        
        guard let url = URL(string: blogs[indexPath.row].link) else { return indexPath }
        self.connectBlogUrl(url: url)

        return indexPath
    }
}
