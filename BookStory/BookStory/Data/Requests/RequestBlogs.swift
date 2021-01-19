//
//  RequestBlogs.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/18.
//

import Alamofire
import RxCocoa

func requestBlogs<T>(query: String, start: Int = 1, display: Int = 10, relay: PublishRelay<T>) {
    let url = URLConfig.blog
    
    AF.request(url,
       method: .get,
       parameters: ["query" : query, "start" : start, "display" : display],
       encoding: URLEncoding.default,
       headers: ["X-Naver-Client-Id":SecretKeySet.naverClientId, "X-Naver-Client-Secret":SecretKeySet.naverClientSecret]
    )
    .validate(statusCode: 200..<300)
    .responseJSON { (json) in
        guard let data = json.data else { return }
        let response = try? JSONDecoder().decode(BlogSearchResponse.self, from: data)
        
        guard let items = response?.items else { return }
        if T.self == [BlogItem].self {
            relay.accept(
                items.map { item in
                    BlogItem(
                        title: item.title,
                        link: item.link,
                        description: item.description,
                        bloggername: item.bloggername,
                        postDate: item.postDate
                    )
                } as! T
            )
        } else { print("request blogs - 왜 타입이 안맞을까???") }
    }
}
