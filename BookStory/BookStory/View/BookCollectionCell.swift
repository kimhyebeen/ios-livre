//
//  BookCollectionCell.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/20.
//

import UIKit

class BookCollectionCell: UICollectionViewCell {
    static let identifier = "BookCollectionCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
    }
    
    func setupView() {
        
    }
}

/*
 var title: String
 var image: String
 var author: String
 var publishDate: Date?
 var isbn: String
 
 var publishDateString: String {
     let formatter = DateFormatter().then {
         $0.dateFormat = "yyyy-MM-dd"
     }
     if let pd = publishDate { return "출간일: \(formatter.string(from: pd))" }
     else { return "출간일: -" }
 }
 */
