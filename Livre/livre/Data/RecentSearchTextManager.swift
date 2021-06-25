//
//  RecentSearchConfig.swift
//  livre
//
//  Created by 김혜빈 on 2021/04/04.
//

import RxCocoa

class RecentSearchTextManager {
    static let shared = RecentSearchTextManager()
    private init() {}
    
    let replayRelay = ReplayRelay<String>.create(bufferSize: 5)
    
    func addStringToReplayRelay(value: String) {
        replayRelay.accept(value)
    }
}
