//
//  ViewExtension.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/18.
//

import UIKit

extension UIView {
    func setGradient(colors: [CGColor], sx: CGFloat = 1, sy: CGFloat = 0, ex: CGFloat = 0, ey: CGFloat = 1) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = colors
        gradient.frame = bounds
        gradient.startPoint = CGPoint(x: sx, y: sy)
        gradient.endPoint = CGPoint(x: ex, y: ey)
        layer.addSublayer(gradient)
    }
}
