//
//  RealmStorage.swift
//  Todolist
//
//  Created by 유석환 on 2022/08/06.
//

import Foundation

import RealmSwift

enum RealmStorage {
    static func taskResults() -> Results<Task>? {
        guard let realm = try? Realm() else { return nil }

        return realm.objects(Task.self)
    }

    static func create(task: Task) {
        guard let realm = try? Realm() else { return }

        try? realm.write {
            realm.add(task)
        }
    }

    static func update(task: Task) {
        guard let realm = try? Realm() else { return }

        try? realm.write {
            realm.add(task, update: .modified)
        }
    }

    static func updateIsChecked(of task: Task, value: Bool) {
        guard let realm = try? Realm() else { return }

        try? realm.write {
            task.isChecked = value
            realm.add(task, update: .modified)
        }
    }

    static func updateIsCheckedToFalse(of task: Task) {
        Self.updateIsChecked(of: task, value: false)
    }

    static func delete(task: Task) {
        guard let realm = try? Realm() else { return }

        try? realm.write {
            realm.delete(task)
        }
    }
}
