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
    let titleLabel = UILabel()
        .then {
            $0.textColor = UIColor(named: "deep_gray")
            $0.font = UIFont.boldSystemFont(ofSize: 24)
        }
    let resultLabel = UILabel()
        .then {
            $0.textColor = UIColor(named: "deep_gray")
            $0.font = UIFont.boldSystemFont(ofSize: 20)
            $0.text = "검색결과"
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
        setupTitleLabel()
        setupResultLabel()
    }
}

// MARK: +UI
extension BlogListViewController {
    func setupBarView() {
        self.view.addSubview(barView)
        
        barView.translatesAutoresizingMaskIntoConstraints = false
        barView.widthAnchor.constraint(equalToConstant: deviceWidth * 0.3).isActive = true
        barView.heightAnchor.constraint(equalToConstant: 4).isActive = true
        barView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 8).isActive = true
        barView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    func setupTitleLabel() {
        titleLabel.text = "\'\(word)\' "
        self.view.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15).isActive = true
        titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.view.trailingAnchor, constant: (resultLabel.frame.width + 15) * -1).isActive = true
    }
    
    func setupResultLabel() {
        self.view.addSubview(resultLabel)
        
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        resultLabel.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        resultLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        resultLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.view.trailingAnchor, constant: -15).isActive = true
    }
}
