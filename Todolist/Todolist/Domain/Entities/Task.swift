//
//  Task.swift
//  Todolist
//
//  Created by 유석환 on 2022/06/24.
//

import Foundation

struct Task {
    let id: String
    var publishedDate: String
    var context: String
    var isDaily: Bool
    var isChecked: Bool

    init(id: String, publishedDate: String, context: String, isDaily: Bool, isChecked: Bool) {
        self.id = id
        self.publishedDate = publishedDate
        self.context = context
        self.isDaily = isDaily
        self.isChecked = isChecked
    }

    init?(cdTask: CDTask?) {
        guard let cdTask = cdTask,
              let id = cdTask.id else { return nil }

        self.id = id
        self.publishedDate = cdTask.publishedDate ?? Const.minDate
        self.context = cdTask.context ?? ""
        self.isDaily = cdTask.isDaily
        self.isChecked = cdTask.isChecked
    }
}
