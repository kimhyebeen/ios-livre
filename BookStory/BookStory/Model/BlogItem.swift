//
//  BlogItem.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/19.
//

import Foundation

struct BlogItem {
    var title: String
    var link: String
    var description: String
    var bloggername: String
    var postDate: Date
    
    var postDateString: String {
        let formatter = DateFormatter().then {
            $0.dateFormat = "yyyy.MM.dd"
        }
        return "\(formatter.string(from: postDate))"
    }
}
