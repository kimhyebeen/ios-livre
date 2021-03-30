//
//  UserDefaultsConfig.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/18.
//

import Foundation

struct RewardConfig {
    private static let currentLevel = "currentLevel"
    private static let currentPoint = "currentPoint"
    private static let points = "points"
    
    static var isDataEmpty: Bool {
        return UserDefaults.standard.array(forKey: points) == nil
    }
    
    static func initReward() {
        UserDefaults.standard.set(1, forKey: currentLevel)
        UserDefaults.standard.set(0, forKey: currentPoint)
        UserDefaults.standard.set([0, 100, 300, 700, 1500, 3100, 6300, 12700, 25500, 51100, 200000], forKey: points)
    }
    
    static func getCurrentLevel() -> Int {
        return UserDefaults.standard.integer(forKey: currentLevel)
    }

    static func getCurrentPoint() -> Float {
        return UserDefaults.standard.float(forKey: currentPoint)
    }
    
    static func getPointList() -> [Float]? {
        return UserDefaults.standard.array(forKey: points) as? [Float]
    }
    
    static func addPoint(point: Float) {
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
    
    private static func setCurrentLevel(level: Int) {
        UserDefaults.standard.set(level, forKey: currentLevel)
    }
    
    private static func setCurrentPoint(point: Float) {
        UserDefaults.standard.set(point, forKey: currentPoint)
    }
}
