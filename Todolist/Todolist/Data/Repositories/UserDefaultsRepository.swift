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
        let nextID = UserDefaults.standard.integer(.nextTaskID)

        UserDefaults.standard.set(nextID + 1, key: .nextTaskID)

        return nextID
    }

    static func saveLastFetchDate(value: String) {
        UserDefaults.standard.set(value, key: .lastFetchDate)
    }

    static func lastFetchDate() -> String {
        return UserDefaults.standard.string(.lastFetchDate)
    }

    static func saveAppearance(value: Int) {
        UserDefaults.standard.set(value, key: .appearance)
    }

    static func currentAppearance() -> Int {
        return UserDefaults.standard.integer(.appearance)
    }
}
