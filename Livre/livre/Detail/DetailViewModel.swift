//
//  BookInfoViewModel.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/22.
//

import RxSwift
import RxCocoa

class DetailViewModel {
    var isbn: String = ""
    var startShoppingIndex = 1
    let disposeBag = DisposeBag()
    let shoppings = PublishRelay<[Shopping]>()
    let keywords = PublishRelay<String>()
    
    init(isbn: String) {
        self.isbn = isbn
    }
    
    func requestBookItem() -> Observable<Book> {
        return requestBookSearch(query: isbn)
    }
    
    func requestKeywordList(_ description: String) {
        requestKeywords(body: KeywordRequestBody(argument: KeywordRequestArgument(question: description)))
            .take(3)
            .subscribe(onNext: { [weak self] item in
                self?.keywords.accept(item)
            })
            .disposed(by: disposeBag)
    }
    
    func requestShoppingList(author: String, word: String) {
        let searchWord = word.count > 10 ? String(word[...word.index(word.startIndex, offsetBy: 10)]) : word
        
        requestShoppings(query: "책 \(author) \(searchWord)", start: startShoppingIndex)
            .subscribe(onNext: { [weak self] items in
                self?.shoppings.accept(items)
            })
            .disposed(by: disposeBag)
        startShoppingIndex += 10
    }
}
