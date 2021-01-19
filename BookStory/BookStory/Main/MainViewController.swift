//
//  ViewController.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/17.
//

import UIKit
import RxSwift
import Lottie

class MainViewController: BaseViewController {
    let animationView = AnimationView(name: "main-book")
    let searchFieldView = SearchField()
    let basicLabel = UILabel()
    let rewardView = RewardView()
    let startLevelLabel = UILabel()
    let endLevelLabel = UILabel()
    let pointLabel = UILabel()
    let recentSearchTable = UITableView()
    
    var recentSearchDisposable: Disposable?
    let spaceForLeftRight: CGFloat = 25
    private let vm = MainViewModel()
    
    var recentSearchList: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupReward(reward: vm.getReward())
        bindViewModel()
        
        animationView.play()
        rewardView.setupLevel()
        rewardView.startAnimation()
    }

    func setupView() {
        self.view.setGradient(colors: [UIColor(named: "gradient_start")!.cgColor, UIColor(named: "gradient_end")!.cgColor])
        
        setupAnimationView()
        setupSearchFieldView()
        setupBasicLabel()
        setupPointLabel()
        setupRewardView()
        setupStartLevelLabel()
        setupEndLevelLabel()
        setupRecentSearchTable()
        
        recentSearchTable.register(RecentSearchTableCell.self, forCellReuseIdentifier: RecentSearchTableCell.identifier)
        searchFieldView.textfield.delegate = self
        searchFieldView.button.addTarget(self, action: #selector(clickSearchButton(_:)), for: .touchUpInside)
    }
    
    func setupReward(reward: Reward) {
        guard let lists = reward.points else {
            print("리워드 리스트가 없네요.")
            return
        }
        rewardView.setProgress(value: reward.point/lists[reward.level], width: self.view.frame.width - 70)
        startLevelLabel.text = "lv.\(reward.level)"
        endLevelLabel.text = "lv.\(reward.level+1)"
        pointLabel.text = "\(Int(reward.point)) / \(Int(lists[reward.level]))"
    }
    
    func bindViewModel() {
        recentSearchList = []
        recentSearchDisposable = vm.output.recentSearchString.subscribe(onNext: { [weak self] text in
            self?.recentSearchList.append(text)
        })
    }
    
    @objc func clickSearchButton(_ sender: UIButton) {
        guard let text = searchFieldView.textfield.text, !text.isEmpty else {
            self.showToast(view: self.view, message: "검색어를 입력해주세요")
            return
        }
        vm.saveRecentSearchString(value: text)
        vm.addRewardPoint(value: text)
        searchFieldView.textfield.text = ""
        recentSearchDisposable?.dispose()
        
        let nextVC = DetailViewController()
        nextVC.modalPresentationStyle = .fullScreen
        self.show(nextVC, sender: nil)
    }

}

// MARK: Delegate
extension MainViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.recentSearchTable.reloadData()
        self.recentSearchTable.isHidden = false
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        self.recentSearchTable.isHidden = true
        return true
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recentSearchList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: RecentSearchTableCell = tableView.dequeueReusableCell(withIdentifier: RecentSearchTableCell.identifier, for: indexPath) as? RecentSearchTableCell else {
            print("recent search table cell을 불러올 수 없습니다.")
            return RecentSearchTableCell()
        }
        let count = recentSearchList.count - 1
        cell.selectionStyle = .none
        cell.setupCellInformation(value: recentSearchList[count - indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let count = recentSearchList.count - 1
        searchFieldView.textfield.text = recentSearchList[count - indexPath.row]
        self.view.endEditing(true)
        
        return indexPath
    }
}
