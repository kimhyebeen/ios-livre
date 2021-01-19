//
//  ShoppingSearchResponse.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/18.
//

import Foundation

struct ShoppingSearchResponse: Codable {
    let lastBuildDate: String
    let total: Int
    let start: Int
    let display: Int
    let items: [ShoppingSearchItem]
}

struct ShoppingSearchItem: Codable {
    let title: String
    let link: String
    let image: String
    let lprice: String
    let hprice: String
    let mallName: String
    let productId: String
    let productType: String
    let brand: String
    let maker: String
    let category1: String
    let category2: String
    let category3: String
    let category4: String
    
    var priceString: String {
        let low = Int(lprice) ?? 0
        let high = Int(hprice) ?? 0
        var price = low
        if price == 0 { price = high }
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let result = numberFormatter.string(from: NSNumber(value: price))! + "원"
        return result
    }
    
    var category: String {
        return "\(category1)/\(category2)/\(category3)/\(category4)"
    }
}
