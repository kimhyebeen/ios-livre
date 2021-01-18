//
//  ViewController.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/17.
//

import UIKit
import Lottie

class MainViewController: UIViewController {
    let animationView = AnimationView(name: "main-book")
    let searchFieldView = SearchField()
    let basicLabel = UILabel()
    let rewardView = RewardView()
    let startLevelLabel = UILabel()
    let endLevelLabel = UILabel()
    let pointLabel = UILabel()
    
    let spaceForLeftRight: CGFloat = 25
    private let vm = MainViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupReward(reward: vm.getReward())
    }

    func setupView() {
        self.view.setGradient(colors: [UIColor(named: "gradient_start")!.cgColor, UIColor(named: "gradient_end")!.cgColor])
        
        setupAnimationView()
        setupSearchFieldView()
        setupBasicLabel()
        setupRewardView()
        setupStartLevelLabel()
        setupEndLevelLabel()
        setupPointLabel()
    }
    
    func setupReward(reward: Reward) {
        guard let lists = reward.points else {
            print("리워드 리스트가 없네요.")
            return
        }
        rewardView.setProgress(value: reward.point/lists[reward.level], width: self.view.frame.width - 70)
        startLevelLabel.text = "lv.\(reward.level)"
        endLevelLabel.text = "lv.\(reward.level+1)"
        pointLabel.text = "\(reward.point)/\(lists[reward.level])"
    }

}

