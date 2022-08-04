//
//  TaskRepository.swift
//  Todolist
//
//  Created by 유석환 on 2022/06/27.
//

import Foundation

final class TaskRepository {
    private let storage = CoreDataStorage()

    func create(task: Task) {
        if storage.create(task: task) {
            print("success")
        } else {
            print("failure")
        }
    }

    func fetchAllTasks(completion: @escaping ([Task]) -> Void) {
        DispatchQueue.global().async { [weak self] in
            let tasks = self?.storage.fetchAllTasks().compactMap { Task(cdTask: $0) }

            completion(tasks ?? [])
        }
    }

    func fetchTask(by id: String, completion: @escaping (Task?) -> Void) {
        DispatchQueue.global().async { [weak self] in
            let task = Task(cdTask: self?.storage.fetchTask(by: id))

            completion(task)
        }
    }

    func update(task: Task) {
        if storage.update(task: task) {
            print("success")
        } else {
            print("failure")
        }
    }

    func delete(task: Task) {
        if storage.delete(task: task) {
            print("success")
        } else {
            print("failure")
        }
    }

    func updateTasksAsOfToday(completion: @escaping ([Task]) -> Void) {
        fetchAllTasks { tasks in
            var updatedTasks = tasks

            tasks.forEach { [weak self] task in
                if !task.isDaily && task.isChecked {
                    updatedTasks = updatedTasks.filter { $0.id != task.id }
                    self?.delete(task: task)
                }
            }

            updatedTasks = updatedTasks.map {
                Task(id: $0.id,
                     context: $0.context,
                     isDaily: $0.isDaily,
                     isChecked: false)
            }

            updatedTasks.forEach { [weak self] task in
                self?.update(task: task)
            }

            completion(updatedTasks)
        }
    }
}
