//
//  DetailViewController+UI.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/20.
//

import UIKit
import Lottie

extension SearchViewController {
    func setupBackgroundImage() {
        let backgroundView = SearchBackgroundView(frame: self.view.frame)
        self.view.addSubview(backgroundView)
    }
    
    // MARK: Home Icon
    func setupHomeIcon() {
        self.view.addSubview(homeIcon)
        
        homeIcon.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(-30)
        }
        
        setupButtonOnHomeIcon()
    }
    
    private func setupButtonOnHomeIcon() {
        let button = UIButton()
        button.addTarget(self, action: #selector(clickHomeIcon(_:)), for: .touchUpInside)
        self.view.addSubview(button)
        
        button.snp.makeConstraints { make in
            make.top.equalTo(homeIcon.snp.top)
            make.bottom.equalTo(homeIcon.snp.bottom)
            make.leading.equalTo(homeIcon.snp.leading)
            make.trailing.equalTo(homeIcon.snp.trailing)
        }
    }
    
    // MARK: Search Field
    func setupSearchField() {
        searchField.backgroundColor = UIColor(named: "pale_gray")
        searchField.setRoundedRectangle()
        searchField.textfield.text = initSearchText
        searchField.textfield.delegate = self
        searchField.button.addTarget(self, action: #selector(clickSearchButton(_:)), for: .touchUpInside)
        self.view.addSubview(searchField)
        
        searchField.snp.makeConstraints { make in
            make.centerY.equalTo(homeIcon.snp.centerY)
            make.leading.equalTo(homeIcon.snp.trailing).offset(15)
            make.trailing.equalToSuperview().offset(-15)
        }
    }
    
    // MARK: Book Card Field
    func setupBookCardCollectionField() {
        self.view.addSubview(bookCardField)
        
        bookCardField.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.35)
            make.centerX.equalToSuperview()
            make.top.equalTo(searchField.snp.bottom).offset(40)
        }
    }
    
    // MARK: Empty Label
    func setupEmptyLabel() {
        emptyLabel.text = "검색 결과가 존재하지 않습니다"
        emptyLabel.fontGmarketSansLight(14)
        emptyLabel.textColor = UIColor(named: "label_color")
        self.view.addSubview(emptyLabel)

        emptyLabel.snp.makeConstraints { make in
            make.center.equalTo(bookCardField.snp.center)
        }
    }
    
    // MARK: Back Button
    func setupBackPageButton() {
        backPageButton.setImage(UIImage(named: "arrow_left")!.withTintColor(.white), for: .normal)
        backPageButton.imageView?.layer.cornerRadius = 10
        backPageButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        backPageButton.addTarget(self, action: #selector(clickBackButton(_:)), for: .touchUpInside)
        self.view.addSubview(backPageButton)

        backPageButton.snp.makeConstraints { make in
            make.width.equalTo(bookCardField.spaceForLeftRight)
            make.height.equalTo(bookCardField.cellHeight)
            make.bottom.equalTo(bookCardField.snp.bottom)
            make.leading.equalToSuperview()
        }
    }

    // MARK: Next Button
    func setupNextPageButton() {
        nextPageButton.setImage(UIImage(named: "arrow_right")!.withTintColor(.white), for: .normal)
        nextPageButton.imageView?.layer.cornerRadius = 10
        nextPageButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        nextPageButton.addTarget(self, action: #selector(clickNextButton(_:)), for: .touchUpInside)
        self.view.addSubview(nextPageButton)

        nextPageButton.snp.makeConstraints { make in
            make.width.equalTo(bookCardField.spaceForLeftRight)
            make.height.equalTo(bookCardField.cellHeight)
            make.bottom.equalTo(bookCardField.snp.bottom)
            make.trailing.equalToSuperview()
        }
    }

//    // MARK: Blog Field
//    func setupBlogField() {
//        blogField.moreBlogButton.addTarget(self, action: #selector(self.moveToBlogListViewController(_:)), for: .touchUpInside)
//        scrollContentsView.addSubview(blogField)
//
//        blogField.snp.makeConstraints { make in
//            make.width.equalToSuperview().multipliedBy(0.9)
//            make.height.equalTo(300)
//            make.centerX.equalTo(scrollContentsView.snp.centerX)
//            make.top.equalTo(bookCollectionField.snp.bottom).offset(20)
//        }
//    }
}
