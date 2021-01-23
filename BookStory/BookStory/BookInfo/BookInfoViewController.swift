//
//  BookInfoViewController.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/22.
//

import UIKit
import RxSwift

class BookInfoViewController: UIViewController {
    var isbn: String = ""
    var vm: BookInfoViewModel!
    var shoppings: [Shopping] = []
    var keywords: [String] = []
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        vm = BookInfoViewModel(isbn: isbn)
        setupView()
        bindViewModel()
    }
    
    func setupView() {
        self.view.backgroundColor = UIColor(named: "pale_gray")
    }
    
    func bindViewModel() {
        vm.shoppings.subscribe(onNext: { [weak self] shoppings in
            print("shopping : \(shoppings[0].mallName)")
            self?.shoppings.append(contentsOf: shoppings)
        }).disposed(by: disposeBag)
        
        vm.keywords.subscribe(onNext: { [weak self] keywords in
            print("keyword : \(keywords)")
            self?.keywords = keywords
        }).disposed(by: disposeBag)
        
        vm.requestBookItem().subscribe(onSuccess: { [weak self] book in
            print("book : \(book.title)")
            self?.vm.requestShoppingList(book.title)
            self?.vm.requestKeywordList(book.description)
        }).disposed(by: disposeBag)
    }
}
