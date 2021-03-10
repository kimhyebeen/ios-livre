//
//  NewsListViewModel.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/22.
//

import RxSwift
import RxCocoa

class NewsListViewModel {
    var word: String = ""
    var startIndex = 1
    let disposeBag = DisposeBag()
    let news = PublishRelay<[NewsItem]>()
    
    init(word: String) {
        self.word = word
        self.requestNewsItems()
    }
    
    func requestNewsItems() {
        requestNews(query: word, start: startIndex)
            .subscribe(onNext: { [weak self] items in
                self?.news.accept(items)
            }).disposed(by: disposeBag)
        startIndex += 10
    }
}

