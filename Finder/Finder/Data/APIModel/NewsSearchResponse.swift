//
//  NewsSearchResponse.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/18.
//

import Foundation

struct NewsSearchResponse: Codable {
    let lastBuildDate: String
    let total: Int
    let start: Int
    let display: Int
    let items: [NewsSearchItem]
}

struct NewsSearchItem: Codable {
    let title: String
    let originallink: String
    let link: String
    let description: String
    let pubDate: String
    
    var publishDate: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss"
        formatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let endIndex = pubDate.index(pubDate.startIndex, offsetBy: 24)
        return formatter.date(from: String(pubDate[...endIndex]))
    }
}
