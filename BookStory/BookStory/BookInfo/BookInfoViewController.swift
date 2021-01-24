//
//  BookInfoViewController.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/22.
//

import UIKit
import RxSwift

class BookInfoViewController: UIViewController {
    let backButton = UIButton()
        .then {
            $0.imageView?.frame.size = CGSize(width: 24, height: 24)
            $0.imageView?.backgroundColor = UIColor(named: "light_gray_blue")
            $0.imageView?.layer.cornerRadius = 12
            $0.setImage(UIImage(named: "arrow_left"), for: .normal)
            $0.imageEdgeInsets = UIEdgeInsets(top: 10.5, left: 10.5, bottom: 10.5, right: 10.5)
        }
    let tagView = TagStack()
    
    var isbn: String = ""
    var vm: BookInfoViewModel!
    var shoppings: [Shopping] = []
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
        
        setupBackButton()
        setupTagView()
    }
    
    func bindViewModel() {
        vm.shoppings.subscribe(onNext: { [weak self] shoppings in
            print("shopping : \(shoppings[0].mallName)")
            self?.shoppings.append(contentsOf: shoppings)
        }).disposed(by: disposeBag)
        
        vm.keywords.subscribe(onNext: { [weak self] keyword in
            self?.tagView.addLabel(value: keyword)
        }).disposed(by: disposeBag)
        
        vm.requestBookItem().subscribe(onNext: { [weak self] book in
            print("book : \(book.title)")
            self?.vm.requestShoppingList(book.title)
            self?.vm.requestKeywordList(book.description)
        }).disposed(by: disposeBag)
    }
    
    @objc func clickBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
