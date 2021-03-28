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
    var publishDate: Date?
    var isbn: String
    
    var authorString: String {
        "저자: \(author)"
    }
    
    var publishDateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        if let pd = publishDate { return "출간일: \(formatter.string(from: pd))" }
        else { return "출간일: -" }
    }
}
