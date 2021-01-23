//
//  RequestKeywords.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/18.
//

import RxCocoa
import Alamofire

func requestKeywords<T>(body: KeywordRequestBody, relay: PublishRelay<T>) {
    let url = URLConfig.keyword
    var request = URLRequest(url: URL(string: url)!)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.timeoutInterval = 10
    
    // Codable Model을 Data로 변환
    let requestBody = try? JSONEncoder().encode(body)
    if let requestBody = requestBody {
        request.httpBody = requestBody
    }
    
    AF.request(request).responseString { (response) in
        switch response.result {
        case .success:
            if let data = response.data, let item = try? JSONDecoder().decode(KeywordResponse.self, from: data) {

                relay.accept(
                    item.returnObject.keywords.map { $0.keyword } as! T
                )
            }
        case .failure(let error):
            print("🚫 Keyword - Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
        }
    }
}
