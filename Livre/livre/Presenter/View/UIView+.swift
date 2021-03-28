//
//  ViewExtension.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/18.
//

import UIKit

extension UIView {
    // MARK: 모서리 둥근 직사각형 배경 구현
    func setRoundedRectangle(radius: CGFloat = 10) {
        layer.cornerRadius = radius
        layer.shadowColor = UIColor(named: "shadow_color")!.cgColor
        layer.shadowRadius = 4
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
    // MARK: 그라디언트 배경 구현
    func setGradient(colors: [CGColor], sx: CGFloat = 1, sy: CGFloat = 0, ex: CGFloat = 0, ey: CGFloat = 1) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = colors
        gradient.frame = bounds
        gradient.startPoint = CGPoint(x: sx, y: sy)
        gradient.endPoint = CGPoint(x: ex, y: ey)
        layer.addSublayer(gradient)
    }
    
    func setShadow(radius: CGFloat, opacity: Float, color: UIColor, offset: CGSize = CGSize(width: 0, height: 0)) {
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
    }
}
