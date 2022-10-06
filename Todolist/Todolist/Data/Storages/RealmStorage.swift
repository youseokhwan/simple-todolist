//
//  RealmStorage.swift
//  Todolist
//
//  Created by 유석환 on 2022/08/06.
//

import Foundation

import RealmSwift

enum RealmStorage {
    static func migration() {
        let configuration = Realm.Configuration(
            schemaVersion: 2,
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 2 {
                    migration.enumerateObjects(ofType: Task.className()) { oldObject, newObject in
                        guard let oldObject = oldObject,
                              let newObject = newObject else { return }

                        newObject["title"] = oldObject["context"]
                        newObject["isDone"] = oldObject["isChecked"]
                        newObject["createdDate"] = Date()
                    }
                }
            }
        )

        Realm.Configuration.defaultConfiguration = configuration
    }

    static func taskResults() -> Results<Task>? {
        guard let realm = try? Realm() else { return nil }

        return realm.objects(Task.self)
    }

    static func create(task: Task) {
        guard let realm = try? Realm() else { return }

        let results = realm.objects(OrderOfTask.self)

        try? realm.write {
            if results.isEmpty {
                realm.create(OrderOfTask.self)
            }

            results.first?.ids.append(task.id)
            realm.add(task)
        }
    }

    static func update(task: Task) {
        guard let realm = try? Realm() else { return }

        try? realm.write {
            realm.add(task, update: .modified)
        }
    }

    static func updateIsDone(of task: Task, value: Bool) {
        guard let realm = try? Realm() else { return }

        try? realm.write {
            task.isDone = value
            realm.add(task, update: .modified)
        }
    }

    static func updateIsDoneToFalse(of task: Task) {
        Self.updateIsDone(of: task, value: false)
    }

    static func delete(task: Task) {
        guard let realm = try? Realm() else { return }

        let results = realm.objects(OrderOfTask.self)

        try? realm.write {
            results.first?.ids.remove(at: results.first?.ids.firstIndex(of: task.id) ?? 0)
            realm.delete(task)
        }
    }
}
