//
//  NewsListViewModel.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/22.
//

import RxCocoa

class NewsListViewModel {
    var word: String = ""
    var startIndex = 1
    
    let news = PublishRelay<[NewsItem]>()
    
    init(word: String) {
        self.word = word
        self.requestNewsItems()
    }
    
    func requestNewsItems() {
        startIndex = 1
        requestBlogs(query: word, start: startIndex, relay: news)
    }
    
    func requestMoreNewsItems() {
        startIndex += 10
        requestBlogs(query: word, start: startIndex, relay: news)
    }
}

