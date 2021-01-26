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
            $0.imageView?.backgroundColor = UIColor(named: "pale_gray")
            $0.imageView?.layer.cornerRadius = 12
            $0.setImage(UIImage(named: "arrow_left"), for: .normal)
            $0.imageEdgeInsets = UIEdgeInsets(top: 10.5, left: 10.5, bottom: 10.5, right: 10.5)
        }
    let tagView = TagStack()
    let bookCard = BookCard()
    var shoppingCollectionView: UICollectionView!
    let flowLayout = UICollectionViewFlowLayout()
        .then {
            $0.itemSize = CGSize(width: UIScreen.main.bounds.width * 0.43, height: 57)
            $0.scrollDirection = .vertical
        }
    
    var word: String = ""
    var isbn: String = ""
    var vm: BookInfoViewModel!
    var shoppings: [Shopping] = []
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        vm = BookInfoViewModel(isbn: isbn, word: word)
        setupView()
        bindViewModel()
    }
    
    func setupView() {
        setupBackground()
        
        setupBackButton()
        setupTagView()
        setupBookCard()
        setupShoppingCollectionView()
    }
    
    func bindViewModel() {
        vm.shoppings.subscribe(onNext: { [weak self] shoppings in
            if shoppings.count == 0 { return }
            self?.shoppings.append(contentsOf: shoppings)
            self?.shoppingCollectionView.reloadData()
        }).disposed(by: disposeBag)
        
        vm.keywords.subscribe(onNext: { [weak self] keyword in
            self?.tagView.addLabel(value: keyword)
        }).disposed(by: disposeBag)
        
        vm.requestBookItem().subscribe(onNext: { [weak self] book in
            self?.vm.requestShoppingList(author: book.author)
            self?.vm.requestKeywordList(book.description)
            self?.bookCard.setBookInformation(item: book)
        }).disposed(by: disposeBag)
    }
    
    func connectShoppingUrl(url: URL) {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            print("BookInfoViewController - 쇼핑 url에 연결하지 못했습니다.")
        }
    }
    
    @objc func clickBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension BookInfoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shoppings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: ShoppingCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: ShoppingCollectionCell.identifier, for: indexPath) as? ShoppingCollectionCell else {
            return ShoppingCollectionCell()
        }
        
        cell.setShoppingInformation(item: shoppings[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        guard let url = URL(string: self.shoppings[indexPath.row].link) else { return true }
        self.connectShoppingUrl(url: url)

        return true
    }
}
