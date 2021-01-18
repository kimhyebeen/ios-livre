//
//  KeywordRequestBody.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/18.
//

import Foundation

struct KeywordRequestBody: Codable {
    var key: String = SecretKeySet.keywordKey
    var serviceId: String = SecretKeySet.keywordServiceId
    var argument: KeywordRequestArgument
}

struct KeywordRequestArgument: Codable {
    var question: String
}
