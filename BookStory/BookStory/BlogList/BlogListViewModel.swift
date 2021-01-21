//
//  BlogListViewModel.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/22.
//

import RxCocoa

class BlogListViewModel {
    var word: String = ""
    var total = 0
    var startIndex = 1
    
    let blogs = PublishRelay<BlogItem>()
    let hasMoreBlogs = PublishRelay<Bool>()
    
    init(word: String, total: Int) {
        self.word = word
        self.total = total
    }
    
    func requestBlogItems() {
        startIndex = 1
        requestBlogs(query: word, start: startIndex, relay: blogs)
    }
    
    func requestMoreBlogItems() {
        startIndex += 10
        if (startIndex > total - 10) {
            startIndex = total - 10
            hasMoreBlogs.accept(false)
        }
        requestBlogs(query: word, start: startIndex, relay: blogs)
    }
}
