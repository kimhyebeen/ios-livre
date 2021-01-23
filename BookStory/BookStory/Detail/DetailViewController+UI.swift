//
//  DetailViewController+UI.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/20.
//

import UIKit
import Lottie

extension DetailViewController {
    func setupBackgroundImage() {
        let imageView = UIImageView()
            .then {
                $0.image = UIImage(named: "bg_detail")
                $0.contentMode = .scaleAspectFill
            }
        self.view.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
    
    // MARK: Home Icon
    func setupHomeIcon() {
        self.view.addSubview(homeIcon)
        
        homeIcon.translatesAutoresizingMaskIntoConstraints = false
        homeIcon.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10).isActive = true
        homeIcon.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: -30).isActive = true
        
        setupButtonOnHomeIcon()
    }
    
    private func setupButtonOnHomeIcon() {
        let button = UIButton()
        button.addTarget(self, action: #selector(clickHomeIcon(_:)), for: .touchUpInside)
        self.view.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: homeIcon.topAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: homeIcon.bottomAnchor).isActive = true
        button.leadingAnchor.constraint(equalTo: homeIcon.leadingAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: homeIcon.trailingAnchor).isActive = true
    }
    
    // MARK: Search Field
    func setupSearchField() {
        searchField.textfield.text = initSearchText
        searchField.textfield.delegate = self
        searchField.button.addTarget(self, action: #selector(clickSearchButton(_:)), for: .touchUpInside)
        self.view.addSubview(searchField)
        
        searchField.translatesAutoresizingMaskIntoConstraints = false
        searchField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.9).isActive = true
        searchField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        searchField.topAnchor.constraint(equalTo: homeIcon.bottomAnchor, constant: -20).isActive = true
    }
    
    // MARK: Book Collection Field
    func setupBookCollectionField() {
        bookCollectionField.delegate = self
        scrollContentsView.addSubview(bookCollectionField)
        
        bookCollectionField.translatesAutoresizingMaskIntoConstraints = false
        bookCollectionField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.75).isActive = true
        bookCollectionField.heightAnchor.constraint(equalToConstant: 130).isActive = true
        bookCollectionField.topAnchor.constraint(equalTo: scrollContentsView.topAnchor, constant: 80).isActive = true
        bookCollectionField.centerXAnchor.constraint(equalTo: scrollContentsView.centerXAnchor).isActive = true
    
        setupAnimationViewOnBookCollectionField()
    }
    
    // MARK: Animation View
    func setupAnimationViewOnBookCollectionField() {
        scrollContentsView.addSubview(animationOnBCF)
        animationOnBCF.play()
        
        animationOnBCF.translatesAutoresizingMaskIntoConstraints = false
        animationOnBCF.widthAnchor.constraint(equalToConstant: 140).isActive = true
        animationOnBCF.heightAnchor.constraint(equalToConstant: 120).isActive = true
        animationOnBCF.centerXAnchor.constraint(equalTo: bookCollectionField.centerXAnchor).isActive = true
        animationOnBCF.bottomAnchor.constraint(equalTo: bookCollectionField.topAnchor, constant: 40).isActive = true
    }
    
    // MARK: Back Button
    func setupBackPageButton() {
        backPageButton.imageView?.backgroundColor = UIColor(named: "coral")?.withAlphaComponent(0.6)
        backPageButton.imageView?.layer.cornerRadius = 10
        scrollContentsView.addSubview(backPageButton)
        
        backPageButton.translatesAutoresizingMaskIntoConstraints = false
        backPageButton.widthAnchor.constraint(equalToConstant: 45).isActive = true
        backPageButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        backPageButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        backPageButton.centerYAnchor.constraint(equalTo: bookCollectionField.centerYAnchor).isActive = true
        backPageButton.trailingAnchor.constraint(equalTo: bookCollectionField.leadingAnchor, constant: -2).isActive = true
        backPageButton.addTarget(self, action: #selector(clickBackButton(_:)), for: .touchUpInside)
    }
    
    // MARK: Next Button
    func setupNextPageButton() {
        nextPageButton.imageView?.backgroundColor = UIColor(named: "coral")?.withAlphaComponent(0.6)
        nextPageButton.imageView?.layer.cornerRadius = 10
        scrollContentsView.addSubview(nextPageButton)
        
        nextPageButton.translatesAutoresizingMaskIntoConstraints = false
        nextPageButton.widthAnchor.constraint(equalToConstant: 45).isActive = true
        nextPageButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        nextPageButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        nextPageButton.centerYAnchor.constraint(equalTo: bookCollectionField.centerYAnchor).isActive = true
        nextPageButton.leadingAnchor.constraint(equalTo: bookCollectionField.trailingAnchor, constant: 2).isActive = true
        nextPageButton.addTarget(self, action: #selector(clickNextButton(_:)), for: .touchUpInside)
    }
    
    func setupEmptyLabel() {
        scrollContentsView.addSubview(emptyLabel)
        
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyLabel.centerXAnchor.constraint(equalTo: bookCollectionField.centerXAnchor).isActive = true
        emptyLabel.centerYAnchor.constraint(equalTo: bookCollectionField.centerYAnchor).isActive = true
    }
    
    // MARK: Blog Field
    func setupBlogField() {
        blogField.moreBlogButton.addTarget(self, action: #selector(self.moveToBlogListViewController(_:)), for: .touchUpInside)
        scrollContentsView.addSubview(blogField)
        
        blogField.translatesAutoresizingMaskIntoConstraints = false
        blogField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.9).isActive = true
        blogField.heightAnchor.constraint(equalToConstant: 300).isActive = true
        blogField.centerXAnchor.constraint(equalTo: scrollContentsView.centerXAnchor).isActive = true
        blogField.topAnchor.constraint(equalTo: bookCollectionField.bottomAnchor, constant: 20).isActive = true
    }
    
    // MARK: News Field
    func setupNewsField() {
        newsField.moreNewsButton.addTarget(self, action: #selector(self.moveToNewsListViewController(_:)), for: .touchUpInside)
        scrollContentsView.addSubview(newsField)
        
        newsField.translatesAutoresizingMaskIntoConstraints = false
        newsField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.9).isActive = true
        newsField.heightAnchor.constraint(equalToConstant: 300).isActive = true
        newsField.centerXAnchor.constraint(equalTo: scrollContentsView.centerXAnchor).isActive = true
        newsField.topAnchor.constraint(equalTo: blogField.bottomAnchor, constant: 40).isActive = true
    }
    
    // MARK: Scroll View
    func setupContentsView() {
        scrollView.addSubview(scrollContentsView)
        
        scrollContentsView.translatesAutoresizingMaskIntoConstraints = false
        scrollContentsView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        scrollContentsView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        scrollContentsView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        scrollContentsView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        scrollContentsView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        scrollContentsView.heightAnchor.constraint(equalToConstant: 900).isActive = true
    }
    
    func setupScrollView() {
        scrollView.contentSize = scrollContentsView.bounds.size
        scrollView.delegate = self
        self.view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 20).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -40).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
}
