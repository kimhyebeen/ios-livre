//
//  HomeIcon.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/20.
//

import UIKit
import Lottie

class HomeIcon: UIView {
    let icon = AnimationView(name: "home-icon3")
        .then {
            $0.loopMode = .loop
            $0.backgroundColor = UIColor.white.withAlphaComponent(0)
            $0.layer.shadowRadius = 4
            $0.layer.shadowOpacity = 1
            $0.layer.shadowColor = UIColor.white.cgColor
            $0.layer.shadowOffset = CGSize(width: 0, height: 0)
        }
    let label = UILabel()
        .then {
            $0.text = "Home"
            $0.textColor = UIColor(named: "navy")
            $0.font = UIFont.boldSystemFont(ofSize: 24)
            $0.layer.shadowRadius = 4
            $0.layer.shadowOpacity = 1
            $0.layer.shadowColor = UIColor.white.cgColor
            $0.layer.shadowOffset = CGSize(width: 0, height: 0)
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
        label.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: -35).isActive = true
        label.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    func startAnimation() {
        if !icon.isAnimationPlaying { icon.play() }
    }

}
