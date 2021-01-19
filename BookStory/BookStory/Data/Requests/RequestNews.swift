//
//  RequestNews.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/18.
//

import Alamofire
import RxCocoa

func requestNews<T>(query: String, start: Int = 1, display: Int = 10, relay: PublishRelay<T>) {
    let url = URLConfig.news
    
    AF.request(url,
       method: .get,
       parameters: ["query" : query, "start" : start, "display" : display],
       encoding: URLEncoding.default,
       headers: ["X-Naver-Client-Id":SecretKeySet.naverClientId, "X-Naver-Client-Secret":SecretKeySet.naverClientSecret]
    )
    .validate(statusCode: 200..<300)
    .responseJSON { (json) in
        guard let data = json.data else { return }
        let response = try? JSONDecoder().decode(NewsSearchResponse.self, from: data)
        
        guard let items = response?.items else { return }
        if T.self == [NewsItem].self {
            relay.accept(
                items.map { item in
                    NewsItem(
                        title: item.title,
                        link: item.link,
                        description: item.description,
                        publishDate: item.publishDate
                    )
                } as! T
            )
        } else { print("request news - 왜 타입이 안맞을까???") }
    }
}
