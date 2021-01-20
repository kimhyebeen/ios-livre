//
//  DetailViewController.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/19.
//

import UIKit
import RxSwift
import Lottie

class DetailViewController: BaseViewController {
    let homeIcon = HomeIcon()
    let searchField = SearchField()
        .then {
            $0.backgroundColor = UIColor(named: "pale_gray")
            $0.setRoundedRectangle()
        }
    let scrollView = UIScrollView()
    let scrollContentsView = UIView()
    let animationOnBCF = AnimationView(name: "splash-icon")
        .then {
            $0.loopMode = .loop
            $0.contentMode = .scaleAspectFit
        }
    let bookCollectionField = BookCollectionField()
    let backPageButton = UIButton()
        .then {
            $0.setImage(UIImage(named: "arrow_left"), for: .normal)
        }
    let nextPageButton = UIButton()
        .then {
            $0.setImage(UIImage(named: "arrow_right"), for: .normal)
        }
    let blogField = BlogField()
    let newsField = NewsField()
    
    let disposeBag = DisposeBag()
    let vm = DetailViewModel()
    var initSearchText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startAnimation()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        startAnimation()
    }
    
    func startAnimation() {
        homeIcon.startAnimation()
        if !animationOnBCF.isAnimationPlaying { animationOnBCF.play() }
    }
    
    private func setupView() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        setupBackgroundImage()
        setupHomeIcon()
        setupSearchField()
        setupBookCollectionField()
        setupBackPageButton()
        setupNextPageButton()
        setupBlogField()
        setupNewsField()
        setupContentsView()
        setupScrollView()
    }
    
    private func bindViewModel() {
//        vm.output.newsResult.subscribe(onNext: { items in
//            for item in items {
//                print("\(item.title), \(item.publishDateString)")
//            }
//        }).disposed(by: disposeBag)
//        vm.requestAllSearchData(value: "달러구트")
    }
    
    @objc func clickHomeIcon(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func clickBackButton(_ sender: UIButton) {
        bookCollectionField.movePrePage()
    }
    
    @objc func clickNextButton(_ sender: UIButton) {
        bookCollectionField.moveNextPage()
    }

}

extension DetailViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
        homeIcon.startAnimation()
    }
}
