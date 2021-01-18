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
        let recentSearchString = ReplayRelay<String>.create(bufferSize: 5)
    }
    
    func saveRecentSearchString(value: String) {
        output.recentSearchString.accept(value)
    }
    
    func getReward() -> Reward {
        if RewardConfig.isDataEmpty { RewardConfig.initReward() }
        
        return Reward(
            level: RewardConfig.getCurrentLevel(),
            point: RewardConfig.getCurrentPoint(),
            points: RewardConfig.getPointList()
        )
    }
    
    func addRewardPoint(value: String, curPoint: Int, curLevel: Int) {
        RewardConfig.addPoint(point: Float(value.count * 2))
    }
}
