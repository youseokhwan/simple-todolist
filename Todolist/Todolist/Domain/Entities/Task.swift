//
//  Task.swift
//  Todolist
//
//  Created by 유석환 on 2022/06/24.
//

import Foundation

struct Task {
    let id: String
    var context: String
    var isDaily: Bool
    var isChecked: Bool

    init(id: String, context: String, isDaily: Bool, isChecked: Bool) {
        self.id = id
        self.context = context
        self.isDaily = isDaily
        self.isChecked = isChecked
    }

    init?(cdTask: CDTask?) {
        guard let cdTask = cdTask,
              let id = cdTask.id else { return nil }

        self.id = id
        self.context = cdTask.context ?? ""
        self.isDaily = cdTask.isDaily
        self.isChecked = cdTask.isChecked
    }
}
