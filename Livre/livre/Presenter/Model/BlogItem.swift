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
    var postDate: Date?
    
    var postDateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        if let pd = postDate {
            return "\(formatter.string(from: pd))"
        } else { return "" }
    }
}
