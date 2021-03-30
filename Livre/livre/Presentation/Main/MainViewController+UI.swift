//
//  MainViewControllerComponent.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/19.
//

import UIKit
import SnapKit

extension MainViewController {
    // MARK: AnimationView
    func setupAnimationView() {
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        self.view.addSubview(animationView) // 애니메이션뷰를 메인뷰에 추가
        
        animationView.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(200)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(self.view.frame.height * 0.15)
        }
    }
    
    // MARK: SearchFieldView
    func setupSearchFieldView() {
        searchFieldView.textfield.delegate = self
        searchFieldView.button.addTarget(self, action: #selector(clickSearchButton(_:)), for: .touchUpInside)
        searchFieldView.setRoundedRectangle()
        searchFieldView.backgroundColor = UIColor(named: "pale_gray")
        self.view.addSubview(searchFieldView)
        
        searchFieldView.snp.makeConstraints { make in
            make.top.equalTo(animationView.snp.bottom)
            make.leading.equalToSuperview().offset(spaceForLeftRight)
            make.trailing.equalToSuperview().offset(spaceForLeftRight * -1)
        }
    }
    
    // MARK: BasicLabel
    func setupBasicLabel() {
        basicLabel.text = "책을 검색해보세요!\n검색할수록 더 많은 포인트가 지급됩니다!"
        basicLabel.font = UIFont(name: "NotoSansKR-Regular", size: 15)
        basicLabel.numberOfLines = 0
        basicLabel.textAlignment = .center
        basicLabel.textColor = UIColor(named: "label_color")
        self.view.addSubview(basicLabel)
        
        basicLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view.snp.centerY).offset(20)
        }
    }
    
    // MARK: RewardView
    func setupRewardView() {
        self.view.addSubview(rewardView)
        
        rewardView.snp.makeConstraints { make in
            make.bottom.equalTo(pointLabel.snp.top).offset(-30)
            make.leading.equalToSuperview().offset(spaceForLeftRight + 10)
            make.trailing.equalToSuperview().offset(spaceForLeftRight * -1 - 10)
        }
    }
    
    // MARK: StartLevelLabel
    func setupStartLevelLabel() {
        startLevelLabel.text = "lv."
        startLevelLabel.font = UIFont.boldSystemFont(ofSize: 17)
        startLevelLabel.textColor = UIColor(named: "light_gray_blue")
        self.view.addSubview(startLevelLabel)
        
        startLevelLabel.snp.makeConstraints { make in
            make.centerX.equalTo(rewardView.snp.leading)
            make.top.equalTo(rewardView.snp.bottom).offset(4)
        }
    }
    
    // MARK: EndLevelLabel
    func setupEndLevelLabel() {
        endLevelLabel.text = "lv."
        endLevelLabel.font = UIFont.boldSystemFont(ofSize: 17)
        endLevelLabel.textColor = UIColor(named: "light_gray_blue")
        self.view.addSubview(endLevelLabel)
        
        endLevelLabel.snp.makeConstraints { make in
            make.centerX.equalTo(rewardView.snp.trailing)
            make.top.equalTo(rewardView.snp.bottom).offset(4)
        }
    }
    
    // MARK: PointLabel
    func setupPointLabel() {
        pointLabel.text = "-/-"
        pointLabel.font = UIFont.boldSystemFont(ofSize: 18)
        pointLabel.textColor = UIColor(named: "light_gray_blue")
        self.view.addSubview(pointLabel)
        
        pointLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(self.view.frame.height * 0.15 * -1)
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
            make.top.equalTo(searchFieldView.snp.bottom)
            make.leading.equalTo(searchFieldView.snp.leading)
            make.trailing.equalTo(searchFieldView.snp.trailing)
        }
    }
}
