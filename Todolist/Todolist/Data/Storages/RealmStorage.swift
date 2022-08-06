//
//  RealmStorage.swift
//  Todolist
//
//  Created by 유석환 on 2022/08/06.
//

import Foundation

import RealmSwift

final class RealmStorage {
    func fetchAllTasks() -> [Task] {
        guard let realm = try? Realm() else { return [] }

        return Array(realm.objects(Task.self))
    }

    func fetchTask(by id: String) -> Task? {
        guard let realm = try? Realm(),
              let task = realm.object(ofType: Task.self, forPrimaryKey: id) else { return nil }

        return task
    }

    func create(task: Task) {
        guard let realm = try? Realm() else { return }

        try? realm.write {
            realm.add(task)
        }
    }

    func update(task: Task) {
        guard let realm = try? Realm() else { return }

        try? realm.write {
            realm.add(task, update: .modified)
        }
    }

    func delete(task: Task) {
        guard let realm = try? Realm() else { return }

        try? realm.write {
            realm.delete(task)
        }
    }
}
