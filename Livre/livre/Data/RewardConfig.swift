//
//  UserDefaultsConfig.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/18.
//

import Foundation

struct RewardConfig {
    static let shared = RewardConfig()
    private let currentLevel = "currentLevel"
    private let currentPoint = "currentPoint"
    private let points = "points"
    
    var isDataEmpty: Bool {
        return UserDefaults.standard.array(forKey: points) == nil
    }
    
    func initReward() {
        UserDefaults.standard.set(1, forKey: currentLevel)
        UserDefaults.standard.set(0, forKey: currentPoint)
        UserDefaults.standard.set([0, 100, 300, 700, 1500, 3100, 6300, 12700, 25500, 51100, 200000], forKey: points)
    }
    
    func getCurrentLevel() -> Int {
        return UserDefaults.standard.integer(forKey: currentLevel)
    }

    func getCurrentPoint() -> Float {
        return UserDefaults.standard.float(forKey: currentPoint)
    }
    
    func getPointList() -> [Float]? {
        return UserDefaults.standard.array(forKey: points) as? [Float]
    }
    
    func addPoint(point: Float) {
        guard let list = getPointList() else { return }
        let level = getCurrentLevel()
        let total = getCurrentPoint() + point
        if total >= list[level] {
            setCurrentPoint(point: total - list[level])
            setCurrentLevel(level: level+1)
        } else {
            setCurrentPoint(point: total)
        }
    }
    
    private func setCurrentLevel(level: Int) {
        UserDefaults.standard.set(level, forKey: currentLevel)
    }
    
    private func setCurrentPoint(point: Float) {
        UserDefaults.standard.set(point, forKey: currentPoint)
    }
}
