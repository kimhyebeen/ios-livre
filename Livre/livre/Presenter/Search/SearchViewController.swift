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
    let bookCardField = BookCardCollectionField(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 180))
    let emptyLabel = UILabel()
    let backPageButton = UIButton()
    let nextPageButton = UIButton()
        
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
        homeIcon.startAnimation()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        homeIcon.startAnimation()
    }
    
    private func setupView() {
        setupBackgroundImage()
        setupHomeIcon()
        setupSearchField()
        setupBookCardCollectionField()
        setupEmptyLabel()
        setupBackPageButton()
        setupNextPageButton()
//        setupBlogField()
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
                self.showToast(view: self.view, message: "관련 정보를 찾을 수 없습니다.")
            } else {
                self.emptyLabel.isHidden = true
                self.vm.updatePoint(value: self.searchField.textfield.text ?? "")
            }
            self.bookCardField.setBookItems(items: items)
        }).disposed(by: disposeBag)
        
//        vm.output.blogsResult.subscribe(onNext: { [weak self] item in
//            self?.blogField.setTableViewItem(items: [item])
//        }).disposed(by: disposeBag)
    }
    
    // MARK: click event
    @objc func clickHomeIcon(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func clickSearchButton(_ sender: UIButton) {
        self.view.endEditing(true)
        if bookCardField.books.count == 0 { return }
        bookCardField.moveToFirstPage()
    }
    
    @objc func clickBackButton(_ sender: UIButton) {
        bookCardField.moveToPrePage()
    }

    @objc func clickNextButton(_ sender: UIButton) {
        bookCardField.moveToNextPage()
    }
    
    @objc func moveToBlogListViewController(_ sender: UIButton) {
        let nextVC = BlogListViewController()
        nextVC.word = vm.currentWord
        self.present(nextVC, animated: true, completion: nil)
    }

}

// MARK: +Delegate
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
