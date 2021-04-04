//
//  MainViewModel.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/18.
//

import RxSwift
import RxCocoa

class MainViewModel {
    let output = Output()
    
    struct Output {
        let recentSearchString = RecentSearchConfig.shared.replayRelay
    }
    
    func saveRecentSearchString(value: String) {
        output.recentSearchString.accept(value)
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
