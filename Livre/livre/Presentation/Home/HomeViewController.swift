//
//  ViewController.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/17.
//

import UIKit
import RxSwift
import Lottie

class HomeViewController: BaseViewController {
    let animationView = AnimationView(name: "main-book")
    let searchFieldView = SearchField()
    let basicLabel = UILabel()
    let rewardView = RewardView()
    let startLevelLabel = UILabel()
    let endLevelLabel = UILabel()
    let pointLabel = UILabel()
    let recentSearchTable = UITableView()
    
    private let viewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        self.view.setGradient(colors: [UIColor(named: "gradient_start")!.cgColor, UIColor(named: "gradient_end")!.cgColor])
        
        setupAnimationView()
        setupSearchFieldView()
        setupBasicLabel()
        setupPointLabel()
        setupRewardView()
        setupStartLevelLabel()
        setupEndLevelLabel()
        setupRecentSearchTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        searchFieldView.textfield.text = ""
        setupReward(reward: viewModel.getReward())
        viewModel.recentSearchList = []
        viewModel.requestRecentSearchString()
        
        DispatchQueue.main.async { [weak self] in
            self?.animationView.play()
            self?.rewardView.startAnimation()
            self?.rewardView.setupLevel()
        }
    }
    
    private func setupReward(reward: Reward) {
        guard let lists = reward.points else {
            print("리워드 리스트가 없네요.")
            return
        }
        rewardView.setProgress(value: reward.point/lists[reward.level], width: self.view.frame.width - 70)
        startLevelLabel.text = "lv.\(reward.level)"
        endLevelLabel.text = "lv.\(reward.level+1)"
        pointLabel.text = "\(Int(reward.point)) / \(Int(lists[reward.level]))"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
        if !animationView.isAnimationPlaying { animationView.play() }
        if !rewardView.isAnimationPlaying { rewardView.startAnimation() }
    }

    @objc func clickSearchButton(_ sender: UIButton) {
        guard let text = searchFieldView.textfield.text, !text.isEmpty else {
            self.showToast(view: self.view, message: "검색어를 입력해주세요")
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            self?.viewModel.saveRecentSearchString(value: text)
            self?.viewModel.addRewardPoint(value: text)
        }
        
        moveToSearchViewController()
    }
    
    private func moveToSearchViewController() {
        let nextVC = SearchViewController()
        nextVC.initSearchText = searchFieldView.textfield.text ?? ""
        nextVC.modalPresentationStyle = .fullScreen
        self.show(nextVC, sender: nil)
    }
}

// MARK: TextField Delegate
extension HomeViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        recentSearchTable.reloadData()
        recentSearchTable.isHidden = false
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        recentSearchTable.isHidden = true
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        clickSearchButton(searchFieldView.button)
        self.view.endEditing(true)
        return true
    }
}

// MARK: TableView Delegate
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.recentSearchList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: RecentSearchTableCell = tableView.dequeueReusableCell(withIdentifier: RecentSearchTableCell.identifier, for: indexPath) as? RecentSearchTableCell else {
            print("recent search table cell을 불러올 수 없습니다.")
            return RecentSearchTableCell()
        }
        let count = viewModel.recentSearchList.count - 1
        cell.setupCellInformation(value: viewModel.recentSearchList[count - indexPath.row])
        if (indexPath.row == count) {
            cell.layer.cornerRadius = 10
            cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        } else {
            cell.layer.cornerRadius = 0
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let count = viewModel.recentSearchList.count - 1
        searchFieldView.textfield.text = viewModel.recentSearchList[count - indexPath.row]
        self.view.endEditing(true)
        clickSearchButton(searchFieldView.button)
        
        return indexPath
    }
}
