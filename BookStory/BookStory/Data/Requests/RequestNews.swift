//
//  RequestNews.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/18.
//

import Alamofire
import RxSwift

func requestNews(query: String, start: Int = 1, display: Int = 10) -> Observable<[NewsItem]> {
    
    return Observable.create { (observable) in
        let request = AF.request(
            URLConfig.news,
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
            observable.onNext(
                items.map { item in
                    NewsItem(
                        title: item.title,
                        link: item.link,
                        description: item.description,
                        publishDate: item.publishDate
                    )
                }
            )
        }
        return Disposables.create {
            request.cancel()
        }
    }
}
