//
//  Task.swift
//  Todolist
//
//  Created by 유석환 on 2022/06/24.
//

import Foundation

import RealmSwift

typealias TaskID = Int

final class Task: Object {
    @Persisted(primaryKey: true) var id: TaskID
    @Persisted var title: String
    @Persisted var isDone: Bool
    @Persisted var isDaily: Bool
    @Persisted var createdDate: Date

    convenience init(id: Int, title: String, isDone: Bool, isDaily: Bool, createdDate: Date) {
        self.init()
        self.id = id
        self.title = title
        self.isDone = isDone
        self.isDaily = isDaily
        self.createdDate = createdDate
    }

    public static func ==(lhs: Task, rhs: Task) -> Bool {
        return lhs.id == rhs.id
    }
}

final class OrderOfTasks: Object {
    @Persisted var ids = List<TaskID>()
}
