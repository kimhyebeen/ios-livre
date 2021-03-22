//
//  DetailViewController.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/19.
//

import UIKit
import RxSwift
import Lottie

class SearchViewController: BaseViewController {
    let homeIcon = HomeIcon()
    let searchField = SearchField()
        .then {
            $0.backgroundColor = UIColor(named: "pale_gray")
            $0.setRoundedRectangle()
        }
    let scrollView = UIScrollView()
    let scrollContentsView = UIView()
    let animationOnBCF = AnimationView(name: "splash-icon")
        .then {
            $0.loopMode = .loop
            $0.contentMode = .scaleAspectFit
        }
    let bookCollectionField = BookCollectionField()
    let backPageButton = UIButton()
        .then {
            $0.setImage(UIImage(named: "arrow_left"), for: .normal)
        }
    let nextPageButton = UIButton()
        .then {
            $0.setImage(UIImage(named: "arrow_right"), for: .normal)
        }
    let emptyLabel = UILabel()
        .then {
            $0.text = "검색 결과가 존재하지 않습니다"
            $0.font = UIFont(name: "GmarketSansTTFLight", size: 14)
            $0.textColor = UIColor(named: "pale_gray")
        }
    let blogField = BlogField()
    let newsField = NewsField()
    
    let disposeBag = DisposeBag()
    var vm: SearchViewModel!
    var initSearchText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vm = SearchViewModel(value: initSearchText)
        setupView()
        bindViewModel()
        vm.requestBookItems(value: initSearchText)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        super.viewWillAppear(animated)
        startAnimation()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        startAnimation()
    }
    
    func startAnimation() {
        homeIcon.startAnimation()
        if !animationOnBCF.isAnimationPlaying { animationOnBCF.play() }
    }
    
    private func setupView() {
        
        setupBackgroundImage()
        setupHomeIcon()
        setupSearchField()
        setupBookCollectionField()
        setupBackPageButton()
        setupNextPageButton()
        setupEmptyLabel()
        setupBlogField()
        setupNewsField()
        setupContentsView()
        setupScrollView()
    }
    
    private func bindViewModel() {
        searchField.textfield.rx.text.orEmpty
            .bind(to: vm.input.searchWord)
            .disposed(by: disposeBag)
        
        searchField.button.rx.tap
            .bind(to: vm.input.searchButton)
            .disposed(by: disposeBag)
        
        vm.output.booksResult.subscribe(onNext: { [weak self] items in
            guard let self = self else { return }
            if items.count == 0 {
                self.emptyLabel.isHidden = false
                self.blogField.setTableViewItem(items: [])
                self.newsField.setTableViewItem(items: [])
                self.showToast(view: self.view, message: "관련 정보를 찾을 수 없습니다.")
            } else {
                self.emptyLabel.isHidden = true
                self.vm.requestBlogAndNews()
            }
            self.bookCollectionField.setBookItems(items: items)
        }).disposed(by: disposeBag)
        
        vm.output.blogsResult.subscribe(onNext: { [weak self] items in
            self?.blogField.setTableViewItem(items: items)
        }).disposed(by: disposeBag)
        
        vm.output.newsResult.subscribe(onNext: { [weak self] items in
            self?.newsField.setTableViewItem(items: items)
        }).disposed(by: disposeBag)
    }
    
    @objc func clickHomeIcon(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func clickSearchButton(_ sender: UIButton) {
        self.view.endEditing(true)
        scrollView.setContentOffset(.zero, animated: true)
        if bookCollectionField.books.count == 0 { return }
        bookCollectionField.moveToFirstPage()
        blogField.moveToFirstRow()
        newsField.moveToFirstRow()
    }
    
    @objc func clickBackButton(_ sender: UIButton) {
        bookCollectionField.moveToPrePage()
    }
    
    @objc func clickNextButton(_ sender: UIButton) {
        bookCollectionField.moveToNextPage()
    }
    
    @objc func moveToBlogListViewController(_ sender: UIButton) {
        let nextVC = BlogListViewController()
        nextVC.word = vm.currentWord
        self.present(nextVC, animated: true, completion: nil)
    }
    
    @objc func moveToNewsListViewController(_ sender: UIButton) {
        let nextVC = NewsListViewController()
        nextVC.word = vm.currentWord
        self.present(nextVC, animated: true, completion: nil)
    }

}

// MARK: +Delegate
extension SearchViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
        startAnimation()
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else {
            clickSearchButton(searchField.button)
            return true
        }
        
        vm.requestBookItems(value: text)
        clickSearchButton(searchField.button)
        return true
    }
}

extension SearchViewController: BookCollectionFieldDelegate {
    func moveToBookInfoViewController(VC: UIViewController) {
        guard let nextVC: DetailViewController = VC as? DetailViewController else { return }
        nextVC.word = vm.currentWord
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
