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

    static func allTasks() -> [Task] {
        guard let realm = try? Realm() else { return [] }

        return Array(realm.objects(Task.self))
    }

    static func create(task: Task) {
        guard let realm = try? Realm() else { return }

        let results = realm.objects(OrderOfTasks.self)

        try? realm.write {
            if results.isEmpty {
                realm.create(OrderOfTasks.self)
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

    static func delete(task: Task) {
        guard let realm = try? Realm() else { return }

        let results = realm.objects(OrderOfTasks.self)

        try? realm.write {
            if let ids = results.first?.ids {
                ids.remove(at: ids.firstIndex(of: task.id) ?? 0)
                realm.delete(task)
            }
        }
    }

    static func orderOfTasksResults() -> Results<OrderOfTasks>? {
        guard let realm = try? Realm() else { return nil }

        return realm.objects(OrderOfTasks.self)
    }

    static func moveTask(at sourceRow: Int, to destinationRow: Int) {
        guard let realm = try? Realm() else { return }

        let results = realm.objects(OrderOfTasks.self)

        try? realm.write {
            if let ids = results.first?.ids,
               let movedId = results.first?.ids[sourceRow] {
                ids.remove(at: sourceRow)
                ids.insert(movedId, at: destinationRow)
            }
        }
    }
}
