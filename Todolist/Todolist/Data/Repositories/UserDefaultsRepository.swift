//
//  UserDefaultsRepository.swift
//  Todolist
//
//  Created by 유석환 on 2022/07/07.
//

import Foundation

enum UserDefaultsRepository {
    static func nextTaskID() -> String {
        let nextID = UserDefaults.standard.integer(forKey: "nextTaskID")
        UserDefaults.standard.set(nextID + 1, forKey: "nextTaskID")

        return "\(nextID)"
    }
}
