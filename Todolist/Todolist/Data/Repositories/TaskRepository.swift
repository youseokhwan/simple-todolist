//
//  TaskRepository.swift
//  Todolist
//
//  Created by 유석환 on 2022/06/27.
//

import Foundation

final class TaskRepository {
    private let storage = RealmStorage()

    func create(task: Task) {
        storage.create(task: task)
    }

    func fetchAllTasks() -> [Task] {
        return storage.fetchAllTasks()
    }

    func fetchTask(by id: String) -> Task? {
        return storage.fetchTask(by: id)
    }

    func update(task: Task) {
        storage.update(task: task)
    }

    func delete(task: Task) {
        storage.delete(task: task)
    }

//    func updateTasksAsOfToday(completion: @escaping ([Task]) -> Void) {
//        fetchAllTasks { tasks in
//            var updatedTasks = tasks
//
//            tasks.forEach { [weak self] task in
//                if !task.isDaily && task.isChecked {
//                    updatedTasks = updatedTasks.filter { $0.id != task.id }
//                    self?.delete(task: task)
//                }
//            }
//
//            updatedTasks = updatedTasks.map {
//                Task(id: $0.id,
//                     context: $0.context,
//                     isDaily: $0.isDaily,
//                     isChecked: false)
//            }
//
//            updatedTasks.forEach { [weak self] task in
//                self?.update(task: task)
//            }
//
//            completion(updatedTasks)
//        }
//    }
}
