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
    
    var currentWord = ""
    
    struct Input {
        let searchWord = PublishSubject<String>()
        let searchButton = PublishSubject<Void>()
    }
    
    struct Output {
        let booksResult = PublishRelay<[Book]>()
//        let blogsResult = PublishRelay<BlogItem>()
        let pointResult = BehaviorRelay<String>(value: "lv \(RewardConfig.getCurrentLevel()). \(Int(RewardConfig.getCurrentPoint()))/\(Int(RewardConfig.getPointList()![RewardConfig.getCurrentLevel()]))")
    }
    
    init(value: String) {
        currentWord = value
        input.searchButton.withLatestFrom(input.searchWord)
            .filter { !$0.isEmpty }
            .subscribe(onNext: { [weak self] text in
                self?.requestBookItems(value: text)
            }).disposed(by: disposeBag)
    }
    
    func requestBookItems(value: String) {
        currentWord = value
        requestBookSearch(query: value).subscribe(onNext: { [weak self] item in
            self?.output.booksResult.accept(item)
        }).disposed(by: disposeBag)
    }
    
//    func requestBlogItems() {
//        requestBlogs(query: currentWord).subscribe(onNext: { [weak self] items in
//            self?.output.blogsResult.accept(items[0])
//        }).disposed(by: disposeBag)
//    }
    
    func updatePoint(value: String) {
        RewardConfig.addPoint(point: Float(value.count * 2))
        output.pointResult.accept(getPointString())
    }
    
    private func getPointString() -> String {
        return "lv \(RewardConfig.getCurrentLevel()). \(Int(RewardConfig.getCurrentPoint()))/\(Int(RewardConfig.getPointList()![RewardConfig.getCurrentLevel()]))"
    }
}
