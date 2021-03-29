//
//  RequestBookSearch.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/18.
//

import Alamofire
import RxSwift

func requestBookSearch(query: String, start: Int = 1, display: Int = 10) -> Observable<[Book]> {
    
    return Observable.create { (observable) in
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
            observable.onNext(items.map { Book(title: $0.title, image: $0.image, author: $0.author, price: $0.priceString, isbn: $0.isbn, description: $0.description, publisher: $0.publisher, publishDate: $0.publishDate) })
            observable.onCompleted()
        }
        return Disposables.create {
            request.cancel()
        }
    }
}
