//
//  DetailViewModel.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/19.
//

import RxSwift
import RxCocoa

class SearchViewModel {
    let input = Input()
    let output = Output()
    private let disposeBag = DisposeBag()
    
    struct Input {
        let searchWord = PublishSubject<String>()
        let searchButton = PublishSubject<Void>()
    }
    
    struct Output {
        let booksResult = PublishRelay<[Book]>()
        let blogsResult = PublishRelay<[BlogItem]>()
        let recentSearchedText = ReplayRelay<String>.create(bufferSize: 5)
    }
    
    init() {
        input.searchButton.withLatestFrom(input.searchWord)
            .filter { !$0.isEmpty }
            .subscribe(onNext: { [weak self] text in
                self?.requestBookItems(value: text)
                self?.output.recentSearchedText.accept(text)
            }).disposed(by: disposeBag)
    }
    
    func requestBookItems(value: String) {
        RequestNetwork.books(query: value).subscribe(onNext: { [weak self] item in
            self?.output.booksResult.accept(item)
        }).disposed(by: disposeBag)
    }
    
    func requestBlogItems(value: String) {
        RequestNetwork.blogs(query: value).subscribe(onNext: { [weak self] items in
            self?.output.blogsResult.accept(items)
        }).disposed(by: disposeBag)
    }
    
    func updatePoint(value: String) {
        RewardConfig.addPoint(point: Float(value.count * 2))
    }
}
