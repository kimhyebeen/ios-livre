//
//  RewardView.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/19.
//

import UIKit
import Lottie

class RewardView: UIView {
    let startAnimationView = AnimationView(name: "reward-0")
    let endAnimationView = AnimationView(name: "home-0")
    let progressView = UIProgressView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
    }
    
    func setupView() {
        setupStartAnimationView()
        setupEndAnimationView()
        setupProgressView()
    }
    
    func setupStartAnimationView() {
        
    }
    
    func setupEndAnimationView() {
        endAnimationView.contentMode = .scaleAspectFit
        endAnimationView.loopMode = .loop
        self.addSubview(endAnimationView) // 애니메이션뷰를 메인뷰에 추가
        
        endAnimationView.translatesAutoresizingMaskIntoConstraints = false
        endAnimationView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        endAnimationView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        endAnimationView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        endAnimationView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 40).isActive = true
        endAnimationView.play() // 애미메이션뷰 실행
    }
    
    func setupProgressView() {
        progressView.progressTintColor = UIColor(named: "light_gray_blue")
        progressView.backgroundColor = UIColor(named: "navy")
        progressView.setProgress(0.5, animated: true)
        self.addSubview(progressView)
        
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.topAnchor.constraint(equalTo: endAnimationView.bottomAnchor).isActive = true
        progressView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        progressView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        progressView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
    }

}
