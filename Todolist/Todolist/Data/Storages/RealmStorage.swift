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

    static func taskResults() -> Results<Tasks>? {
        guard let realm = try? Realm() else { return nil }

        return realm.objects(Tasks.self)
    }

    static func create(task: Task) {
        guard let realm = try? Realm() else { return }

        let result = realm.objects(Tasks.self)

        try? realm.write {
            if result.isEmpty {
                realm.create(Tasks.self)
            }

            if let items = realm.objects(Tasks.self).first?.items {
                items.append(task)
            }
        }
    }

    static func moveTask(at sourceIndex: Int, to destinationIndex: Int) {
        guard let realm = try? Realm(),
              let tasks = realm.objects(Tasks.self).first?.items else { return }

        let task = tasks[sourceIndex]

        try? realm.write {
            tasks.remove(at: sourceIndex)
            tasks.insert(task, at: destinationIndex)
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

        try? realm.write {
            realm.delete(task)
        }
    }
}
