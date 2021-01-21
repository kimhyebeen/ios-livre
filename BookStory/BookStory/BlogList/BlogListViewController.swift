//
//  BlogListViewController.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/21.
//

import UIKit

class BlogListViewController: UIViewController {
    let deviceWidth = UIScreen.main.bounds.width
    let deviceHeight = UIScreen.main.bounds.height
    var word: String = ""
    
    let barView = UIView()
        .then {
            $0.backgroundColor = UIColor(named: "pale_gray")
            $0.layer.cornerRadius = 2
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        let blurEffect = UIBlurEffect(style: .regular)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.frame = self.view.frame
        self.view.addSubview(visualEffectView)
        
        setupBarView()
    }
}

// MARK: +UI
extension BlogListViewController {
    func setupBarView() {
        self.view.addSubview(barView)
        
        barView.translatesAutoresizingMaskIntoConstraints = false
        barView.widthAnchor.constraint(equalToConstant: deviceWidth * 0.3).isActive = true
        barView.heightAnchor.constraint(equalToConstant: 4).isActive = true
        barView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        barView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
}
