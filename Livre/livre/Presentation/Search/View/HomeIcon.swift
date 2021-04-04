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
    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.backgroundColor = .clear
        setupIcon()
        setupLabel()
    }
    
    private func setupIcon() {
        icon.loopMode = .loop
        icon.backgroundColor = .clear
        icon.setShadow(radius: 4, opacity: 1, color: .white, offset: CGSize(width: 0, height: 0))
        self.addSubview(icon)
        
        icon.snp.makeConstraints { make in
            make.width.equalTo(120)
            make.height.equalTo(120)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
        }
        icon.play()
    }
    
    private func setupLabel() {
        label.text = "홈"
        label.textColor = UIColor(named: "navy")
        label.font = UIFont(name: "Montserrat-Medium", size: 27)
        label.setShadow(radius: 4, opacity: 1, color: .white, offset: CGSize(width: 0, height: 0))
        self.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.centerY.equalTo(icon.snp.centerY)
            make.leading.equalTo(icon.snp.trailing).offset(-40)
            make.trailing.equalToSuperview()
        }
    }
    
    func startAnimation() {
        if icon.isAnimationPlaying { return }
        icon.play()
    }

}
