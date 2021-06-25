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
        searchField.textfield.text = viewModel.initSearchText
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
        bookCardField.bookcardDelegate = self
        self.view.addSubview(bookCardField)
        
        bookCardField.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(self.view.frame.height * 0.35)
            make.centerX.equalToSuperview()
            make.top.equalTo(searchField.snp.bottom).offset(20)
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
        backPageButton.imageEdgeInsets = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
        backPageButton.addTarget(self, action: #selector(clickBackButton(_:)), for: .touchUpInside)
        self.view.addSubview(backPageButton)

        backPageButton.snp.makeConstraints { make in
            make.width.equalTo(bookCardField.spaceForLeftRight)
            make.height.equalTo(UIScreen.main.bounds.width * 0.35)
            make.centerY.equalTo(bookCardField.snp.centerY)
            make.leading.equalToSuperview()
        }
    }

    // MARK: Next Button
    func setupNextPageButton() {
        nextPageButton.setImage(UIImage(named: "arrow_right")!.withTintColor(.white), for: .normal)
        nextPageButton.imageEdgeInsets = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
        nextPageButton.addTarget(self, action: #selector(clickNextButton(_:)), for: .touchUpInside)
        self.view.addSubview(nextPageButton)

        nextPageButton.snp.makeConstraints { make in
            make.width.equalTo(bookCardField.spaceForLeftRight)
            make.height.equalTo(UIScreen.main.bounds.width * 0.35)
            make.centerY.equalTo(bookCardField.snp.centerY)
            make.trailing.equalToSuperview()
        }
    }
    
    // MARK: RecentSearchTable
    func setupRecentSearchTable() {
        recentSearchTable.register(RecentSearchTableCell.self, forCellReuseIdentifier: RecentSearchTableCell.identifier)
        recentSearchTable.isHidden = true
        recentSearchTable.delegate = self
        recentSearchTable.dataSource = self
        recentSearchTable.separatorStyle = .none
        recentSearchTable.isScrollEnabled = false
        recentSearchTable.backgroundColor = .clear
        recentSearchTable.layer.cornerRadius = 10
        recentSearchTable.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        self.view.addSubview(recentSearchTable)
        
        recentSearchTable.snp.makeConstraints { make in
            make.height.equalTo(225)
            make.top.equalTo(searchField.snp.bottom)
            make.leading.equalTo(searchField.snp.leading)
            make.trailing.equalTo(searchField.snp.trailing)
        }
    }
    
    // MARK: FavoriteLabel
    func setupFavoriteLabel() {
        favoriteLabel.text = "즐겨찾는 책"
        favoriteLabel.textColor = UIColor(named: "coral")!
        favoriteLabel.fontGmarketSansMedium(21)
        self.view.addSubview(favoriteLabel)
        
        favoriteLabel.snp.makeConstraints { make in
            make.top.equalTo(bookCardField.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(30)
        }
    }
    
    // MARK: FavoriteEditButton
    func setupFavoriteEditButton() {
        favoriteEditButton.setTitle("편집", for: .normal)
        favoriteEditButton.setTitle("편집취소", for: .selected)
        favoriteEditButton.setTitleColor(UIColor(named: "apricot")!, for: .normal)
        self.view.addSubview(favoriteEditButton)
        
        favoriteEditButton.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.centerY.equalTo(favoriteLabel.snp.centerY)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    // MARK: FavoriteField
    func setupFavoriteField() {
        favoriteField.delegate = self
        self.view.addSubview(favoriteField)
        
        favoriteField.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.top.equalTo(favoriteLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    // MARK: BlogField
    func setupBlogField() {
        blogField.moreBlogButton.addTarget(self, action: #selector(moveToBlogListViewController(_:)), for: .touchUpInside)
        self.view.addSubview(blogField)
        
        blogField.snp.makeConstraints { make in
            make.top.equalTo(favoriteField.snp.bottom).offset(40)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        }
    }
}
