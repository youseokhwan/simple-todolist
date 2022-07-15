//
//  TaskRepository.swift
//  Todolist
//
//  Created by 유석환 on 2022/06/27.
//

import Foundation

final class TaskRepository {
    let storage = CoreDataStorage()

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
}
