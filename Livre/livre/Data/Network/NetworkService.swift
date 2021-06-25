//
//  RequestNetwork.swift
//  livre
//
//  Created by 김혜빈 on 2021/03/30.
//

import Alamofire
import RxSwift

protocol BaseNetworkService: AnyObject {
    func books(query: String, start: Int, display: Int,_ handler: @escaping ([BookResponse]) -> ())
    func blogs(query: String, start: Int, display: Int,_ handler: @escaping ([BlogResponse]) -> ())
    func keywords(body: KeywordRequestBody,_ handler: @escaping (String) -> ())
}

class NetworkService: BaseNetworkService {
    
    static let shared = NetworkService()
    
    func books(query: String, start: Int = 1, display: Int = 10,_ handler: @escaping ([BookResponse]) -> ()) {
        AF.request(
            URLStringSet.book,
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
            handler(items)
        }
    }
    
    func blogs(query: String, start: Int = 1, display: Int = 10,_ handler: @escaping ([BlogResponse]) -> ()) {
        AF.request(
            URLStringSet.blog,
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
            handler(items)
        }
    }
    
    func keywords(body: KeywordRequestBody,_ handler: @escaping (String) -> ()) {
        var request = URLRequest(url: URL(string: URLStringSet.keyword)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10
        
        // Codable Model을 Data로 변환
        if let requestBody = try? JSONEncoder().encode(body) {
            request.httpBody = requestBody
        }
        AF.request(request).responseString { (response) in
            switch response.result {
            case .success:
                if let data = response.data, let item = try? JSONDecoder().decode(KeywordGetResponse.self, from: data) {
                    for obj in item.returnObject.keywords {
                        handler(obj.keyword)
                    }
                }
            case .failure(let error):
                print("🚫 Keyword - Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
            }
        }
    }

}
