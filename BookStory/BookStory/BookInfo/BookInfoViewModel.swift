//
//  BookInfoViewModel.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/22.
//

import RxSwift
import RxCocoa

class BookInfoViewModel {
    var isbn: String = ""
    var startShoppingIndex = 1
    let shoppings = PublishRelay<[Shopping]>()
    let keywords = PublishRelay<[String]>()
    
    init(isbn: String) {
        self.isbn = isbn
    }
    
    func requestBookItem() -> Single<Book> {
        return requestBook(query: isbn)
    }
    
    func requestKeywordList(_ description: String) {
        requestKeywords(body: KeywordRequestBody(argument: KeywordRequestArgument(question: description)), relay: keywords)
    }
    
    func requestShoppingList(_ title: String) {
        requestShoppings(query: title, start: startShoppingIndex, relay: shoppings)
        startShoppingIndex += 10
    }
}
