//
//  RequestShoppings.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/18.
//

import Alamofire
import RxCocoa

func requestShoppings<T>(query: String, start: Int = 1, display: Int = 10, relay: PublishRelay<T>) {
    let url = URLConfig.shopping
    
    AF.request(url,
       method: .get,
       parameters: ["query" : query, "start" : start, "display" : display],
       encoding: URLEncoding.default,
       headers: ["X-Naver-Client-Id":SecretKeySet.naverClientId, "X-Naver-Client-Secret":SecretKeySet.naverClientSecret])
        .validate(statusCode: 200..<300)
        .responseJSON { (json) in
            guard let data = json.data else { return }
            let response = try? JSONDecoder().decode(ShoppingSearchResponse.self, from: data)
            
            guard let items = response?.items else { return }
            if T.self == [Shopping].self {
                relay.accept(
                    items.map { item in
                        Shopping(
                            title: item.title,
                            link: item.link,
                            image: item.image,
                            price: item.priceString,
                            mallName: item.mallName
                        )
                    } as! T
                )
            } else { print("request shoppings - 왜 타입이 안맞을까???") }
    }
}
