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

    func create(task: Task) {
        RealmStorage.create(task: task)
    }

    func update(task: Task) {
        RealmStorage.update(task: task)
    }

    func delete(task: Task) {
        RealmStorage.delete(task: task)
    }

    func orderOfTasks() -> [TaskID] {
        return RealmStorage.orderOfTasks()
    }

    func moveTask(at sourceIndex: Int, to destinationIndex: Int) {
        RealmStorage.moveTask(at: sourceIndex, to: destinationIndex)
    }
}
