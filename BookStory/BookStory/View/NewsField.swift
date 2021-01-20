//
//  NewsField.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/20.
//

import UIKit

class NewsField: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
    }
    
    private func setupView() {
        self.setRoundedRectangle(radius: 20)
        self.backgroundColor = UIColor(named: "pale_gray")
        
        setupTitleLabel()
        setupDivider()
        setupMoreNewsButton()
        setupTableView()
    }

}

// MARK: +UI
extension NewsField {
    private func setupTitleLabel() {
        
    }
    
    private func setupDivider() {
        
    }
    
    private func setupMoreNewsButton() {
        setupMoreInformationButtonView()
        
    }
    
    private func setupMoreInformationButtonView() {
        
    }
    
    private func setupTableView() {
        
    }
}
