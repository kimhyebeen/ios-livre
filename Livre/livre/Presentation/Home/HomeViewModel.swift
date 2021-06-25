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
        RecentSearchConfig.shared.replayRelay.subscribe(onNext: { [weak self] value in
            self?.recentSearchList.append(value)
        }).disposed(by: disposeBag)
    }
    
    func saveRecentSearchString(value: String) {
        RecentSearchConfig.shared.replayRelay.accept(value)
    }
    
    func getReward() -> Reward {
        if RewardConfig.shared.isDataEmpty { RewardConfig.shared.initReward() }
        
        return Reward(
            level: RewardConfig.shared.getCurrentLevel(),
            point: RewardConfig.shared.getCurrentPoint(),
            points: RewardConfig.shared.getPointList()
        )
    }
    
    func addRewardPoint(value: String) {
        RewardConfig.shared.addPoint(point: Float(value.count * 2))
    }
}

extension HomeViewModel: RecentTableAdapterDataSource {
    var numberOfItems: Int { recentSearchList.count }
    
    func getSearchedText(at index: Int) -> String { recentSearchList[index] }
}
