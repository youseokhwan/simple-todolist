//
//  UserDefaultsRepository.swift
//  Todolist
//
//  Created by 유석환 on 2022/07/07.
//

import Foundation

enum UserDefaultsRepository {
    static let minDate = "1900.01.01"

    static func nextTaskID() -> Int {
        let nextID = UserDefaults.standard.integer(forKey: UserDefaultsKey.nextTaskID.rawValue)

        UserDefaults.standard.set(nextID + 1, forKey: UserDefaultsKey.nextTaskID.rawValue)

        return nextID
    }

    static func saveLastFetchDate(value: String) {
        UserDefaults.standard.set(value, forKey: UserDefaultsKey.lastFetchDate.rawValue)
    }

    static func lastFetchDate() -> String {
        return UserDefaults.standard.string(forKey: UserDefaultsKey.lastFetchDate.rawValue) ?? Self.minDate
    }

    static func saveAppearance(value: Int) {
        UserDefaults.standard.set(value, forKey: UserDefaultsKey.appearance.rawValue)
    }

    static func currentAppearance() -> Int {
        return UserDefaults.standard.integer(forKey: UserDefaultsKey.appearance.rawValue)
    }
}
