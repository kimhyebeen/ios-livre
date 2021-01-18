//
//  RewardView.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/19.
//

import UIKit

class RewardView: UIView {
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
        
    }
    
    func setupProgressView() {
        progressView.progressTintColor = UIColor(named: "light_gray_blue")
        progressView.tintColor = UIColor(named: "dark_blue")
        progressView.setProgress(0.5, animated: true)
        self.addSubview(progressView)
        
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        progressView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        progressView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        progressView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
    }

}
