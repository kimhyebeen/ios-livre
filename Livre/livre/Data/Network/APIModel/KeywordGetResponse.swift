//
//  KeywordResponse.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/18.
//

import Foundation

struct KeywordGetResponse: Codable {
    let result: String
    let returnObject: KeywordReturn
    
    enum CodingKeys: String, CodingKey {
        case returnObject = "return_object"
        case result
    }
}

struct KeywordReturn: Codable {
    let question: String
    let keylists: [KeywordResponse]
    
    var keywords: [KeywordResponse] {
        var keys: [KeywordResponse] = []
        for item in keylists {
            if item.weight < 0.03 { break }
            if keys.count >= 5 { break }
            keys.append(item)
        }
        return keys
    }
}

struct KeywordResponse: Codable {
    let keyword: String
    let weight: Double
}
