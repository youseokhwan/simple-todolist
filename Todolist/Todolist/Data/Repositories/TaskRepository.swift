//
//  TaskRepository.swift
//  Todolist
//
//  Created by 유석환 on 2022/06/27.
//

import Foundation

import RealmSwift

final class TaskRepository {
    func allTasks() -> [Task] {
        return RealmStorage.allTasks()
    }

    func orderOfTasksResults() -> Results<OrderOfTasks>? {
        return RealmStorage.orderOfTasksResults()
    }

    func create(task: Task) {
        RealmStorage.create(task: task)
    }

    func update(task: Task) {
        RealmStorage.update(task: task)
    }

    func delete(task: Task) {
        RealmStorage.delete(task: task)
    }

    func moveTask(at sourceRow: Int, to destinationRow: Int) {
        RealmStorage.moveTask(at: sourceRow, to: destinationRow)
    }
}
