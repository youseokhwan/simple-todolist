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
        guard let realm = try? Realm(),
              let orderOfTasks = realm.objects(OrderOfTasks.self).first?.ids,
              let index = orderOfTasks.firstIndex(of: task.id) else { return }

        try? realm.write {
            realm.delete(task)
            orderOfTasks.remove(at: index)
        }
    }

    static func orderOfTasks() -> [TaskID] {
        guard let realm = try? Realm(),
              let object = realm.objects(OrderOfTasks.self).first else { return [] }

        return Array(object.ids)
    }

    static func moveTask(at sourceIndex: Int, to destinationIndex: Int) {
        guard let realm = try? Realm(),
              let orderOfTasks = realm.objects(OrderOfTasks.self).first?.ids else { return }

        try? realm.write {
            let movedID = orderOfTasks[sourceIndex]

            orderOfTasks.remove(at: sourceIndex)
            orderOfTasks.insert(movedID, at: destinationIndex)
        }
    }
}
