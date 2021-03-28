//
//  BookInfoViewController.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/22.
//

import UIKit
import RxSwift

class DetailViewController: BaseViewController {
    let backButton = UIButton()
    let tagView = TagStack()
    let bookCard = BookCard()
    var shoppingCollectionView: UICollectionView!
    let flowLayout = UICollectionViewFlowLayout()
    
    var word: String = ""
    var isbn: String = ""
    var vm: DetailViewModel!
    var shoppings: [Shopping] = []
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        vm = DetailViewModel(isbn: isbn)
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
            self?.vm.requestShoppingList(author: book.author, word: book.title)
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

// MARK: +Delegate
extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
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
