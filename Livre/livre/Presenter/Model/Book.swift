//
//  Book.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/22.
//

import Foundation

struct Book {
    var title: String
    var image: String
    var author: String
    var price: String
    var description: String
    var publisher: String
    var publishDate: Date?
    
    var publishDateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        if let pd = publishDate {
            return "\(formatter.string(from: pd))"
        } else { return "" }
    }
}
