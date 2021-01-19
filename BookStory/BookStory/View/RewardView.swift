//
//  RewardView.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/19.
//

import UIKit
import Lottie

class RewardView: UIView {
    private var startAnimationView: AnimationView!
    private let progressView = UIProgressView()
    
    private let rewardSize: CGFloat = 120

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let level = RewardConfig.getCurrentLevel()
        startAnimationView = AnimationView(name: "reward-\(level-1)")
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        let level = RewardConfig.getCurrentLevel()
        startAnimationView = AnimationView(name: "reward-\(level-1)")
        setupView()
    }
    
    private func setupView() {
        setupStartAnimationView()
        setupProgressView()
    }
    
    private func setupStartAnimationView() {
        startAnimationView.contentMode = .scaleAspectFit
        startAnimationView.loopMode = .loop
        startAnimationView.frame = CGRect(x: (rewardSize/2) * -1, y: 0, width: rewardSize, height: rewardSize)
        self.addSubview(startAnimationView)
        
        startAnimationView.play()
    }
    
    private func setupProgressView() {
        progressView.progressTintColor = UIColor(named: "light_gray_blue")
        progressView.backgroundColor = UIColor(named: "navy")
        progressView.setProgress(0.01, animated: true)
        self.addSubview(progressView)
        
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.topAnchor.constraint(equalTo: startAnimationView.bottomAnchor, constant: -20).isActive = true
        progressView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        progressView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        progressView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    func setProgress(value: Float, width: CGFloat) {
        progressView.setProgress(value, animated: true)
        var dx: CGFloat = width * CGFloat(progressView.progress) - (rewardSize/2)
        if dx < 0 { dx = (rewardSize/2) * -1 }
        startAnimationView.frame.origin = CGPoint(x: width * CGFloat(progressView.progress) - (rewardSize/2), y: 0)
    }
    
    func startAnimation() {
        startAnimationView.play()
    }

}
