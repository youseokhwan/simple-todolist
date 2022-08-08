//
//  TaskRepository.swift
//  Todolist
//
//  Created by 유석환 on 2022/06/27.
//

import Foundation

final class TaskRepository {
    func create(task: Task) {
        RealmStorage.create(task: task)
    }

    func fetchAllTasks() -> [Task] {
        return RealmStorage.fetchAllTasks()
    }

    func fetchTask(by id: String) -> Task? {
        return RealmStorage.fetchTask(by: id)
    }

    func update(task: Task) {
        RealmStorage.update(task: task)
    }

    func updateIsChecked(of task: Task, value: Bool) {
        RealmStorage.updateIsChecked(of: task, value: value)
    }

    func delete(task: Task) {
        RealmStorage.delete(task: task)
    }
}
