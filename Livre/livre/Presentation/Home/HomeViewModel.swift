//
//  MainViewModel.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/18.
//

import RxSwift
import RxCocoa

class HomeViewModel {
    var recentSearchList: [String] = []
    private let disposeBag = DisposeBag()
    
    func requestRecentSearchString() {
        RecentSearchTextManager.shared.replayRelay.subscribe(onNext: { [weak self] value in
            self?.recentSearchList.append(value)
        }).disposed(by: disposeBag)
    }
    
    func saveRecentSearchString(value: String) {
        RecentSearchTextManager.shared.replayRelay.accept(value)
    }
    
    func getReward() -> Reward {
        if RewardService.shared.isDataEmpty { RewardService.shared.initReward() }
        
        return Reward(
            level: RewardService.shared.getCurrentLevel(),
            point: RewardService.shared.getCurrentPoint(),
            points: RewardService.shared.getPointList()
        )
    }
    
    func addRewardPoint(value: String) {
        RewardService.shared.addPoint(point: Float(value.count * 2))
    }
}

extension HomeViewModel: RecentTableAdapterDataSource {
    var numberOfItems: Int { recentSearchList.count }
    
    func getSearchedText(at index: Int) -> String { recentSearchList[index] }
}
