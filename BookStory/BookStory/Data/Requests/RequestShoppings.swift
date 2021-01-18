//
//  RequestShoppings.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/18.
//

import Alamofire
import RxSwift

func requestShoppings(query: String, start: Int = 1, display: Int = 10) {
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
            // todo - response 데이터 활용
    }
}
