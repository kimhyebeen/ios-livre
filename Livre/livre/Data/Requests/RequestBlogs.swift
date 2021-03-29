//
//  RequestBlogs.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/18.
//

import Alamofire
import RxSwift

func requestBlogs(query: String, start: Int = 1, display: Int = 10) -> Observable<[BlogItem]> {
    
    return Observable.create { (observable) in
        let request = AF.request(
            URLConfig.blog,
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
            observable.onNext(items.map { BlogItem(title: $0.title, link: $0.link, description: $0.description, bloggername: $0.bloggername, postDate: $0.postDate) })
        }
        return Disposables.create { request.cancel() }
    }
    
}
