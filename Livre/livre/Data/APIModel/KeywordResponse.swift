//
//  KeywordResponse.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/18.
//

import Foundation

struct KeywordResponse: Codable {
    let result: String
    let returnObject: KeywordReturn
    
    enum CodingKeys: String, CodingKey {
        case returnObject = "return_object"
        case result
    }
}

struct KeywordReturn: Codable {
    let question: String
    let keylists: [KeywordItem]
    
    var keywords: [KeywordItem] {
        var keys: [KeywordItem] = []
        for item in keylists {
            if item.weight < 0.03 { break }
            if keys.count >= 5 { break }
            keys.append(item)
        }
        return keys
    }
}

struct KeywordItem: Codable {
    let keyword: String
    let weight: Double
}
