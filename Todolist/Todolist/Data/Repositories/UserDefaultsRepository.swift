//
//  UserDefaultsRepository.swift
//  Todolist
//
//  Created by 유석환 on 2022/07/07.
//

import Foundation

enum UserDefaultsRepository {
    static func nextTaskID() -> Int {
        let nextID = UserDefaults.standard.integer(forKey: Const.nextTaskID)

        UserDefaults.standard.set(nextID + 1, forKey: Const.nextTaskID)

        return nextID
    }

    static func saveLastFetchDate(value: String) {
        UserDefaults.standard.set(value, forKey: Const.lastFetchDate)
    }

    static func lastFetchDate() -> String {
        return UserDefaults.standard.string(forKey: Const.lastFetchDate) ?? Const.minDate
    }

    static func saveAppearance(value: Int) {
        UserDefaults.standard.set(value, forKey: Const.appearance)
    }

    static func currentAppearance() -> Int {
        return UserDefaults.standard.integer(forKey: Const.appearance)
    }
}
