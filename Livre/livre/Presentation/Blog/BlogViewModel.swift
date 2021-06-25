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
    let output = Output()
    private let networkService: BaseNetworkService?
    private let disposeBag = DisposeBag()
    
    struct Output {
        let blogs = PublishRelay<[BlogItem]>()
    }
    
    init(word: String, networkService: BaseNetworkService) {
        self.word = word
        self.networkService = networkService
        self.requestBlogItems()
    }
    
    func requestBlogItems() {
        func mappingToBlogItem(_ data: BlogResponse) -> BlogItem { BlogItem(title: data.title, link: data.bloggerlink, description: data.description, bloggername: data.bloggername, postDate: data.postDate)}
        
        networkService?.blogs(query: word, start: startIndex, display: 10) { [weak self] response in
            self?.output.blogs.accept(response.map { mappingToBlogItem($0) })
            self?.startIndex += 10
        }
    }
}
