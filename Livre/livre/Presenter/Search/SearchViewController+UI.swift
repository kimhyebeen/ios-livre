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
            make.width.equalToSuperview().multipliedBy(0.9)
            make.centerX.equalToSuperview()
            make.top.equalTo(homeIcon.snp.bottom).offset(-20)
        }
    }
    
    // MARK: Book Collection Field
    func setupBookCollectionField() {
        bookCollectionField.delegate = self
        scrollContentsView.addSubview(bookCollectionField)
        
        bookCollectionField.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.75)
            make.height.equalTo(130)
            make.centerX.equalTo(scrollContentsView.snp.centerX)
            make.top.equalTo(scrollContentsView.snp.top).offset(80)
        }
    
        setupAnimationViewOnBookCollectionField()
    }
    
    // MARK: Animation View
    func setupAnimationViewOnBookCollectionField() {
        animationOnBCF.loopMode = .loop
        animationOnBCF.contentMode = .scaleAspectFit
        scrollContentsView.addSubview(animationOnBCF)
        animationOnBCF.play()
        
        animationOnBCF.snp.makeConstraints { make in
            make.width.equalTo(140)
            make.height.equalTo(120)
            make.centerX.equalTo(bookCollectionField.snp.centerX)
            make.bottom.equalTo(bookCollectionField.snp.top).offset(40)
        }
    }
    
    // MARK: Back Button
    func setupBackPageButton() {
        backPageButton.setImage(UIImage(named: "arrow_left"), for: .normal)
        backPageButton.imageView?.backgroundColor = UIColor(named: "coral")?.withAlphaComponent(0.6)
        backPageButton.imageView?.layer.cornerRadius = 10
        backPageButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        backPageButton.addTarget(self, action: #selector(clickBackButton(_:)), for: .touchUpInside)
        scrollContentsView.addSubview(backPageButton)
        
        backPageButton.snp.makeConstraints { make in
            make.width.equalTo(45)
            make.height.equalTo(45)
            make.centerY.equalTo(bookCollectionField.snp.centerY)
            make.trailing.equalTo(bookCollectionField.snp.leading).offset(-2)
        }
    }
    
    // MARK: Next Button
    func setupNextPageButton() {
        nextPageButton.setImage(UIImage(named: "arrow_right"), for: .normal)
        nextPageButton.imageView?.backgroundColor = UIColor(named: "coral")?.withAlphaComponent(0.6)
        nextPageButton.imageView?.layer.cornerRadius = 10
        nextPageButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        nextPageButton.addTarget(self, action: #selector(clickNextButton(_:)), for: .touchUpInside)
        scrollContentsView.addSubview(nextPageButton)
        
        nextPageButton.snp.makeConstraints { make in
            make.width.equalTo(45)
            make.height.equalTo(45)
            make.centerY.equalTo(bookCollectionField.snp.centerY)
            make.leading.equalTo(bookCollectionField.snp.trailing).offset(2)
        }
    }
    
    // MARK: Empty Label
    func setupEmptyLabel() {
        emptyLabel.text = "검색 결과가 존재하지 않습니다"
        emptyLabel.fontGmarketSansLight(14)
        emptyLabel.textColor = UIColor(named: "pale_gray")
        scrollContentsView.addSubview(emptyLabel)
        
        emptyLabel.snp.makeConstraints { make in
            make.center.equalTo(bookCollectionField.snp.center)
        }
    }
    
    // MARK: Blog Field
    func setupBlogField() {
        blogField.moreBlogButton.addTarget(self, action: #selector(self.moveToBlogListViewController(_:)), for: .touchUpInside)
        scrollContentsView.addSubview(blogField)
        
        blogField.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(300)
            make.centerX.equalTo(scrollContentsView.snp.centerX)
            make.top.equalTo(bookCollectionField.snp.bottom).offset(20)
        }
    }
    
    // MARK: News Field
    func setupNewsField() {
        newsField.moreNewsButton.addTarget(self, action: #selector(self.moveToNewsListViewController(_:)), for: .touchUpInside)
        scrollContentsView.addSubview(newsField)
        
        newsField.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(300)
            make.centerX.equalTo(scrollContentsView.snp.centerX)
            make.top.equalTo(blogField.snp.bottom).offset(40)
        }
    }
    
    // MARK: Scroll View
    func setupContentsView() {
        scrollView.addSubview(scrollContentsView)
        
        scrollContentsView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(900)
            make.top.equalTo(scrollView.snp.top)
            make.bottom.equalTo(scrollView.snp.bottom)
            make.leading.equalTo(scrollView.snp.leading)
            make.trailing.equalTo(scrollView.snp.trailing)
        }
    }
    
    func setupScrollView() {
        scrollView.contentSize = scrollContentsView.bounds.size
        scrollView.delegate = self
        self.view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(searchField.snp.bottom).offset(20)
            make.bottom.equalToSuperview().offset(-40)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
}
