//
//  RequestKeywords.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/18.
//

import RxSwift
import Alamofire

func requestKeywords(body: KeywordRequestBody) -> Observable<String> {
    var request = URLRequest(url: URL(string: URLConfig.keyword)!)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.timeoutInterval = 10
    
    // Codable Model을 Data로 변환
    let requestBody = try? JSONEncoder().encode(body)
    if let requestBody = requestBody {
        request.httpBody = requestBody
    }
    
    return Observable<String>.create { (observable) in
        let request = AF.request(request).responseString { (response) in
            switch response.result {
            case .success:
                if let data = response.data, let item = try? JSONDecoder().decode(KeywordResponse.self, from: data) {
                    for keyword in item.returnObject.keywords {
                        observable.onNext(keyword.keyword)
                    }
                }
                observable.onCompleted()
            case .failure(let error):
                print("🚫 Keyword - Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
            }
        }
        return Disposables.create {
            request.cancel()
        }
    }
}
