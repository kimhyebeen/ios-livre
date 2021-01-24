//
//  RequestBookSearch.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/18.
//

import Alamofire
import RxSwift

func requestBookSearch<T>(query: String, start: Int = 1, display: Int = 10) -> Observable<T> {
    
    return Observable<T>.create { (observable) in
        let request = AF.request(
            URLConfig.book,
            method: .get,
            parameters: ["query" : query, "start" : start, "display" : display],
            encoding: URLEncoding.default,
            headers: ["X-Naver-Client-Id":SecretKeySet.naverClientId, "X-Naver-Client-Secret":SecretKeySet.naverClientSecret]
        )
        .validate(statusCode: 200..<300)
        .responseJSON { (json) in
            guard let data = json.data else { return }
            let response = try? JSONDecoder().decode(BookSearchResponse.self, from: data)
            guard let items = response?.items else { return }
            
            if T.self == [SimpleBookItem].self {
                observable.onNext(
                    items.map { item in
                        SimpleBookItem(
                            title: item.title,
                            image: item.image,
                            author: item.author,
                            publishDate: item.publishDate,
                            isbn: item.isbn
                        )
                    } as! T
                )
            } else {
                observable.onNext(
                    Book(
                        title: items[0].title,
                        image: items[0].image,
                        author: items[0].author,
                        price: items[0].priceString,
                        description: items[0].description,
                        publisher: items[0].publisher,
                        publishDate: items[0].publishDate
                    ) as! T
                )
            }
            observable.onCompleted()
        }
        return Disposables.create {
            request.cancel()
        }
    }
}
