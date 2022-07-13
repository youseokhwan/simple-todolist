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
    
    func fetchAllTasks() -> [CDTask] {
        return storage.fetchAllTasks()
    }

    func fetchTask(id: String) -> CDTask? {
        return storage.fetchTask(by: id)
    }
}
