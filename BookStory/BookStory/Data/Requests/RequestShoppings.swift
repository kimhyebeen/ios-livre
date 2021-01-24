//
//  RequestShoppings.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/18.
//

import Alamofire
import RxSwift

func requestShoppings(query: String, start: Int = 1, display: Int = 10) -> Observable<[Shopping]> {
    
    return Observable.create { (observable) in
        let request = AF.request(
            URLConfig.shopping,
            method: .get,
            parameters: ["query" : query, "start" : start, "display" : display],
            encoding: URLEncoding.default,
            headers: ["X-Naver-Client-Id":SecretKeySet.naverClientId, "X-Naver-Client-Secret":SecretKeySet.naverClientSecret])
            .validate(statusCode: 200..<300)
            .responseJSON { (json) in
                guard let data = json.data else { return }
                let response = try? JSONDecoder().decode(ShoppingSearchResponse.self, from: data)
                
                guard let items = response?.items else { return }
                observable.onNext(
                    items.map { item in
                        Shopping(
                            title: item.title,
                            link: item.link,
                            image: item.image,
                            price: item.priceString,
                            mallName: item.mallName
                        )
                    }
                )
        }
        return Disposables.create {
            request.cancel()
        }
    }
}
