//
//  BaseViewController.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/17.
//

import UIKit
import Then

class BaseViewController: UIViewController {
    func log(where: String,_ msg: String) {
        print("\(`where`)에서 로그발생 : \(msg)")
    }
    
    func showToast(view: UIView, message : String, color: UIColor = .black, font: UIFont = UIFont.systemFont(ofSize: 14.0)) {
        OperationQueue.main.addOperation {
            let toastLabel = self.getToastLabel(view: view, message, color, font)
            view.addSubview(toastLabel)
            UIView.animate(
                withDuration: 2.0,
                delay: 1.5,
                options: .curveEaseOut,
                animations: { toastLabel.alpha = 0.0 },
                completion: {(isCompleted) in toastLabel.removeFromSuperview() }
            )
        }
    }

    private func getToastLabel(view: UIView,_ message: String,_ color: UIColor,_ font: UIFont) -> UILabel {
        var width: CGFloat = CGFloat(message.count * 10 + 40)
        if width > self.view.frame.width * 0.8 {
            width = self.view.frame.width * 0.8
        }
        
        let toastLabel = UILabel(
            frame: CGRect(
                x: view.frame.size.width/2 - width/2,
                y: view.frame.size.height-100,
                width: width,
                height: 35
            )
        ).then { label in
            label.backgroundColor = color.withAlphaComponent(0.6)
            label.textColor = UIColor.white
            label.font = font
            label.textAlignment = .center
            label.text = message
            label.alpha = 1.0
            label.layer.cornerRadius = 15;
            label.clipsToBounds = true
        }
        
        return toastLabel
    }
}
