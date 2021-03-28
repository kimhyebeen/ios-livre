//
//  UILabel+.swift
//  livre
//
//  Created by 김혜빈 on 2021/03/28.
//

import UIKit

extension UILabel {
    func fontGmarketSansLight(_ size: CGFloat) {
        self.font = UIFont(name: "GmarketSansTTFLight", size: size)
    }
    
    func fontGmarketSansMedium(_ size: CGFloat) {
        self.font = UIFont(name: "GmarketSansTTFMedium", size: size)
    }
    
    func fontMontserratMedium(_ size: CGFloat) {
        self.font = UIFont(name: "Montserrat-Medium", size: size)
    }
    
    func fontNotoSansMedium(_ size: CGFloat) {
        self.font = UIFont(name: "NotoSansKR-Medium", size: size)
    }
    
    func fontNotoSansRegular(_ size: CGFloat) {
        self.font = UIFont(name: "NotoSansKR-Regular", size: size)
    }
}
