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
    @Persisted var title: String
    @Persisted var isDaily: Bool
    @Persisted var isDone: Bool

    convenience init(id: Int, title: String, isDaily: Bool, isDone: Bool) {
        self.init()
        self.id = id
        self.title = title
        self.isDaily = isDaily
        self.isDone = isDone
    }
}
