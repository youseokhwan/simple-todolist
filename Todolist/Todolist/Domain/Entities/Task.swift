//
//  Task.swift
//  Todolist
//
//  Created by 유석환 on 2022/06/24.
//

import Foundation

import RealmSwift

final class Task: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var context: String
    @Persisted var isDaily: Bool
    @Persisted var isChecked: Bool

    convenience init(id: Int, context: String, isDaily: Bool, isChecked: Bool) {
        self.init()
        self.id = id
        self.context = context
        self.isDaily = isDaily
        self.isChecked = isChecked
    }
}
