//
//  RequestKeywords.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/18.
//

import RxSwift
import Alamofire

func requestKeywords(body: KeywordRequestBody) {
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
                print(item)
                // todo - 아래처럼 응답 데이터 매핑 후 subject.onNext()
                // subject.onNext(item.return_object.keylists[0].keyword)
            }
        case .failure(let error):
            print("🚫 Keyword - Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
        }
    }
}
