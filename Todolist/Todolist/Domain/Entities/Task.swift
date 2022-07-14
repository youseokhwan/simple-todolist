//
//  Task.swift
//  Todolist
//
//  Created by 유석환 on 2022/06/24.
//

import Foundation

struct Task {
    var id: String?
    var context: String?
    var isDaily: Bool
    var isChecked: Bool

    init(id: String?, context: String?, isDaily: Bool, isChecked: Bool) {
        self.id = id
        self.context = context
        self.isDaily = isDaily
        self.isChecked = isChecked
    }

    init(cdTask: CDTask) {
        if let cdTaskId = cdTask.id, let cdTaskContext = cdTask.context {
            id = cdTaskId
            context = cdTaskContext
            isDaily = cdTask.isDaily
            isChecked = cdTask.isChecked
        } else {
            id = nil
            context = nil
            isDaily = cdTask.isDaily
            isChecked = cdTask.isChecked
        }
    }
}
