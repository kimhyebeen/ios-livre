//
//  NewsListViewController.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/22.
//

import UIKit
import RxSwift

class NewsListViewController: BaseViewController {
    let deviceWidth = UIScreen.main.bounds.width
    let deviceHeight = UIScreen.main.bounds.height
    let disposeBag = DisposeBag()
    var word: String = ""
    var vm: NewsListViewModel!
    var news: [NewsItem] = []
    
    let barView = UIView()
    let titleLabel = UILabel()
    let resultLabel = UILabel()
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        vm = NewsListViewModel(word: word)
        setupView()
        bindViewModel()
    }
    
    func setupView() {
        let blurEffect = UIBlurEffect(style: .light)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.frame = self.view.frame
        self.view.addSubview(visualEffectView)
        
        setupBarView()
        setupTitleLabel()
        setupResultLabel()
        setupTableView()
    }
    
    func bindViewModel() {
        vm.news.subscribe(onNext: { [weak self] items in
            self?.news.append(contentsOf: items)
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)
    }
    
    func connectBlogUrl(url: URL) {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            print("NewsListViewController - 뉴스 url에 연결하지 못했습니다.")
        }
    }
    
    func clickMoreRequestButton() {
        vm.requestNewsItems()
        tableView.reloadData()
    }
    
}

// MARK: +Delegate
extension NewsListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count+1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == news.count {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MoreButtonTableCell.identifier, for: indexPath) as? MoreButtonTableCell else {
                return MoreButtonTableCell()
            }
            
            cell.selectionStyle = .none
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableCell.identifier, for: indexPath) as? NewsTableCell else {
            let emptyCell = NewsTableCell()
            emptyCell.setNewsInformation(item: news[indexPath.row])
            emptyCell.selectionStyle = .none
            return emptyCell
        }
        
        cell.setNewsInformation(item: news[indexPath.row])
        cell.setLightMode()
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.row == news.count {
            self.clickMoreRequestButton()
            return indexPath
        }
        
        guard let url = URL(string: news[indexPath.row].link) else { return indexPath }
        self.connectBlogUrl(url: url)

        return indexPath
    }
}
