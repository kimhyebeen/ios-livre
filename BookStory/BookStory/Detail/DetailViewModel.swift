//
//  DetailViewModel.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/19.
//

import RxSwift
import RxCocoa

class DetailViewModel {
    let input = Input()
    let output = Output()
    private let disposeBag = DisposeBag()
    
    struct Input {
        let searchWord = PublishSubject<String>()
        let searchButton = PublishSubject<Void>()
    }
    
    struct Output {
        let booksResult = PublishRelay<SimpleBookItem>()
        let blogsResult = PublishRelay<BlogItem>()
        let newsResult = PublishRelay<NewsItem>()
    }
    
    init() {
        input.searchButton.withLatestFrom(input.searchWord)
            .subscribe(onNext: { [weak self] text in
                self?.requestAllSearchData(value: text)
            }).disposed(by: disposeBag)
    }
    
    func requestAllSearchData(value: String) {
        
    }
}
