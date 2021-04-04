//
//  RewardView.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/19.
//

import UIKit
import Lottie

class RewardView: UIView {
    private var rewardAnimation: AnimationView!
    private let progressView = UIProgressView()
    private let rewardSize: CGFloat = 120
    
    var isAnimationPlaying: Bool {
        return rewardAnimation.isAnimationPlaying
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        setupStartAnimationView()
        setupProgressView()
        
        self.bringSubviewToFront(rewardAnimation)
    }
    
    // MARK: Methods
    func setProgress(value: Float, width: CGFloat) {
        progressView.setProgress(value, animated: true)
        
        var dx: CGFloat = width * CGFloat(progressView.progress) - (rewardSize/2)
        if dx < 0 { dx = (rewardSize/2) * -1 }
        rewardAnimation.frame.origin = CGPoint(x: width * CGFloat(progressView.progress) - (rewardSize/2), y: 0)
    }
    
    func startAnimation() {
        rewardAnimation.play()
    }
    
    func setupLevel() {
        let level = RewardConfig.getCurrentLevel()
        rewardAnimation.animation = Animation.named("reward-\(level-1)")
        rewardAnimation.play()
    }

}

// MARK: View
extension RewardView {
    private func setupStartAnimationView() {
        let level = RewardConfig.getCurrentLevel()
        rewardAnimation = AnimationView(name: "reward-\(level-1)")
        rewardAnimation.contentMode = .scaleAspectFit
        rewardAnimation.loopMode = .loop
        rewardAnimation.frame = CGRect(x: (rewardSize/2) * -1, y: 0, width: rewardSize, height: rewardSize)
        self.addSubview(rewardAnimation)
        
        rewardAnimation.play()
    }
    
    private func setupProgressView() {
        progressView.progressTintColor = UIColor(named: "light_gray_blue")
        progressView.backgroundColor = UIColor(named: "navy")
        progressView.setProgress(0.01, animated: true)
        self.addSubview(progressView)
        
        progressView.snp.makeConstraints { make in
            make.top.equalTo(rewardAnimation.snp.bottom).offset(-20)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
}
