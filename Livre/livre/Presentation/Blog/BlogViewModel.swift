//
//  BlogListViewModel.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/22.
//

import RxCocoa
import RxSwift

class BlogViewModel {
    var word: String = ""
    var startIndex = 1
    let disposeBag = DisposeBag()
    let blogs = PublishRelay<[BlogItem]>()
    
    init(word: String) {
        self.word = word
        self.requestBlogItems()
    }
    
    func requestBlogItems() {
        requestBlogs(query: word, start: startIndex)
            .subscribe(onNext: { [weak self] items in
                self?.blogs.accept(items)
            }).disposed(by: disposeBag)
        startIndex += 10
    }
}
