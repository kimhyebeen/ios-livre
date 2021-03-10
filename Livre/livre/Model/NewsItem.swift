//
//  NewsItem.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/19.
//

import Foundation

struct NewsItem {
    var title: String
    var link: String
    var description: String
    var publishDate: Date?
    
    var publishDateString: String {
        let formatter = DateFormatter().then {
            $0.dateFormat = "yyyy.MM.dd"
        }
        if let pd = publishDate {
            return "\(formatter.string(from: pd))"
        } else { return "" }
    }
}
