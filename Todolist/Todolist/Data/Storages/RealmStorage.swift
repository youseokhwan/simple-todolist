//
//  RealmStorage.swift
//  Todolist
//
//  Created by 유석환 on 2022/08/06.
//

import Foundation

import RealmSwift

enum RealmStorage {
    static func fetchAllTasks() -> [Task] {
        guard let realm = try? Realm() else { return [] }

        return Array(realm.objects(Task.self))
    }

    static func fetchTask(by id: String) -> Task? {
        guard let realm = try? Realm(),
              let task = realm.object(ofType: Task.self, forPrimaryKey: id) else { return nil }

        return task
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

    static func update(tasks: [Task]) {
        guard let realm = try? Realm() else { return }

        try? realm.write {
            realm.add(tasks, update: .modified)
        }
    }

    static func updateIsChecked(of task: Task, value: Bool) {
        guard let realm = try? Realm() else { return }

        try? realm.write {
            task.isChecked = value
            realm.add(task, update: .modified)
        }
    }

    static func delete(task: Task) {
        guard let realm = try? Realm() else { return }

        try? realm.write {
            realm.delete(task)
        }
    }
}
