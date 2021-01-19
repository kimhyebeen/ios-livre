//
//  SimpleBookItem.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/19.
//

import Foundation

struct SimpleBookItem {
    var title: String
    var image: String
    var author: String
    var publishDate: Date
    
    var publishDateString: String {
        let formatter = DateFormatter().then {
            $0.dateFormat = "yyyy-MM-dd"
        }
        return "출간일: \(formatter.string(from: publishDate))"
    }
}
