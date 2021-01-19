//
//  HomeIcon.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/20.
//

import UIKit
import Lottie

class HomeIcon: UIView {
    let icon = AnimationView(name: "home-icon")
        .then {
            $0.loopMode = .loop
            $0.backgroundColor = UIColor.white.withAlphaComponent(0)
        }
    let label = UILabel()
        .then {
            $0.text = "책이야기"
            $0.textColor = UIColor(named: "pale_gray")
            $0.font = UIFont.boldSystemFont(ofSize: 20)
        }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
    }
    
    private func setupView() {
        self.backgroundColor = UIColor.white.withAlphaComponent(0)
        setupIcon()
        setupLabel()
    }
    
    private func setupIcon() {
        self.addSubview(icon)
        
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.widthAnchor.constraint(equalToConstant: 120).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 120).isActive = true
        icon.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        icon.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        icon.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        icon.play()
    }
    
    private func setupLabel() {
        self.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: icon.centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: -20).isActive = true
        label.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    func startAnimation() {
        if !icon.isAnimationPlaying { icon.play() }
    }

}
