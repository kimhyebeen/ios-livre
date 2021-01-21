//
//  BlogListViewModel.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/22.
//

import RxCocoa

class BlogListViewModel {
    var word: String = ""
    var startIndex = 1
    
    let blogs = PublishRelay<[BlogItem]>()
    
    init(word: String) {
        self.word = word
    }
    
    func requestBlogItems() {
        startIndex = 1
        requestBlogs(query: word, start: startIndex, relay: blogs)
    }
    
    func requestMoreBlogItems() {
        startIndex += 10
        requestBlogs(query: word, start: startIndex, relay: blogs)
    }
}
