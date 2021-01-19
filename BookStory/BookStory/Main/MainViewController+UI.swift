//
//  MainViewControllerComponent.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/19.
//

import UIKit

extension MainViewController {
    // MARK: AnimationView
    func setupAnimationView() {
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        self.view.addSubview(animationView) // 애니메이션뷰를 메인뷰에 추가
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        animationView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        animationView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        animationView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: self.view.frame.height * 0.15).isActive = true
    }
    
    // MARK: SearchFieldView
    func setupSearchFieldView() {
        searchFieldView.textfield.delegate = self
        searchFieldView.button.addTarget(self, action: #selector(clickSearchButton(_:)), for: .touchUpInside)
        searchFieldView.setRoundedRectangle()
        searchFieldView.backgroundColor = UIColor(named: "pale_gray")
        self.view.addSubview(searchFieldView)
        
        searchFieldView.translatesAutoresizingMaskIntoConstraints = false
        searchFieldView.topAnchor.constraint(equalTo: animationView.bottomAnchor, constant: 40).isActive = true
        searchFieldView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: spaceForLeftRight).isActive = true
        searchFieldView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: spaceForLeftRight * -1).isActive = true
    }
    
    // MARK: BasicLabel
    func setupBasicLabel() {
        basicLabel.text = "책을 검색해보세요!\n검색할수록 더 많은 포인트가 지급됩니다!"
        basicLabel.font = UIFont.systemFont(ofSize: 16)
        basicLabel.numberOfLines = 0
        basicLabel.textAlignment = .center
        basicLabel.textColor = UIColor(named: "pale_gray")
        self.view.addSubview(basicLabel)
        
        basicLabel.translatesAutoresizingMaskIntoConstraints = false
        basicLabel.topAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 20).isActive = true
        basicLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    // MARK: RewardView
    func setupRewardView() {
        self.view.addSubview(rewardView)
        
        rewardView.translatesAutoresizingMaskIntoConstraints = false
        rewardView.bottomAnchor.constraint(equalTo: pointLabel.topAnchor, constant: -30).isActive = true
        rewardView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: spaceForLeftRight + 10).isActive = true
        rewardView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: spaceForLeftRight * -1 - 10).isActive = true
    }
    
    // MARK: StartLevelLabel
    func setupStartLevelLabel() {
        startLevelLabel.text = "lv."
        startLevelLabel.font = UIFont.boldSystemFont(ofSize: 17)
        startLevelLabel.textColor = UIColor(named: "light_gray_blue")
        self.view.addSubview(startLevelLabel)
        
        startLevelLabel.translatesAutoresizingMaskIntoConstraints = false
        startLevelLabel.topAnchor.constraint(equalTo: rewardView.bottomAnchor, constant: 4).isActive = true
        startLevelLabel.centerXAnchor.constraint(equalTo: rewardView.leadingAnchor).isActive = true
    }
    
    // MARK: EndLevelLabel
    func setupEndLevelLabel() {
        endLevelLabel.text = "lv."
        endLevelLabel.font = UIFont.boldSystemFont(ofSize: 17)
        endLevelLabel.textColor = UIColor(named: "light_gray_blue")
        self.view.addSubview(endLevelLabel)
        
        endLevelLabel.translatesAutoresizingMaskIntoConstraints = false
        endLevelLabel.topAnchor.constraint(equalTo: rewardView.bottomAnchor, constant: 4).isActive = true
        endLevelLabel.centerXAnchor.constraint(equalTo: rewardView.trailingAnchor).isActive = true
    }
    
    // MARK: PointLabel
    func setupPointLabel() {
        pointLabel.text = "-/-"
        pointLabel.font = UIFont.boldSystemFont(ofSize: 18)
        pointLabel.textColor = UIColor(named: "light_gray_blue")
        self.view.addSubview(pointLabel)
        
        pointLabel.translatesAutoresizingMaskIntoConstraints = false
        pointLabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: self.view.frame.height * 0.15 * -1).isActive = true
        pointLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    // MARK: RecentSearchTable
    func setupRecentSearchTable() {
        recentSearchTable.register(RecentSearchTableCell.self, forCellReuseIdentifier: RecentSearchTableCell.identifier)
        recentSearchTable.delegate = self
        recentSearchTable.dataSource = self
        recentSearchTable.backgroundColor = UIColor(named: "deep_gray")?.withAlphaComponent(0)
        recentSearchTable.isHidden = true
        recentSearchTable.layer.cornerRadius = 10
        recentSearchTable.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        self.view.addSubview(recentSearchTable)
        
        recentSearchTable.translatesAutoresizingMaskIntoConstraints = false
        recentSearchTable.topAnchor.constraint(equalTo: searchFieldView.bottomAnchor).isActive = true
        recentSearchTable.leadingAnchor.constraint(equalTo: searchFieldView.textfield.leadingAnchor).isActive = true
        recentSearchTable.trailingAnchor.constraint(equalTo: searchFieldView.textfield.trailingAnchor).isActive = true
        recentSearchTable.heightAnchor.constraint(equalToConstant: 225).isActive = true
    }
}
