//
//  SearchBackgroundView.swift
//  livre
//
//  Created by 김혜빈 on 2021/03/28.
//

import UIKit

class SearchBackgroundView: UIView {
    
    override func draw(_ rect: CGRect) {
        setupBaseDraw(rect)
        setupMiddleDraw(rect)
        setupFrontDraw(rect)
    }
    
    private func setupBaseDraw(_ rect: CGRect) {
        UIColor(named: "search_background_1")!.setFill()
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.maxX, y: 0))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY))
        path.close()
        path.fill()
    }
    
    private func setupMiddleDraw(_ rect: CGRect) {
        UIColor(named: "search_background_2")!.setFill()
        let path = UIBezierPath()
        path.move(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.width / 27.3 * 19, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.height / 19 * 6))
        path.close()
        path.fill()
    }
    
    private func setupFrontDraw(_ rect: CGRect) {
        UIColor(named: "search_background_3")!.setFill()
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: rect.maxY))
        path.addLine(to: CGPoint(x: 0, y: rect.height / 19 * 3.24))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.height / 19 * 12))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.close()
        path.fill()
    }

}
