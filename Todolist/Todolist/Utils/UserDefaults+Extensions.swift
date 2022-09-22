//
//  UserDefaults+Extensions.swift
//  Todolist
//
//  Created by 유석환 on 2022/09/22.
//

import Foundation

extension UserDefaults {
    func integer(_ key: UserDefaultsKey) -> Int {
        return Self.standard.integer(forKey: key.rawValue)
    }

    func string(_ key: UserDefaultsKey) -> String {
        return Self.standard.string(forKey: key.rawValue) ?? UserDefaultsRepository.minDate
    }

    func set<T>(_ value: T, key: UserDefaultsKey) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
}
