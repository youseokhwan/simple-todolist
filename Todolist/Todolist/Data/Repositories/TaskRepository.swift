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

    func fetchAllTasks() -> [Task] {
        let cdTasks = storage.fetchAllTasks()
        var tasks = [Task]()

        cdTasks.forEach { cdTask in
            let task = Task(cdTask: cdTask)
            tasks.append(task)
        }

        return tasks
    }

    func fetchTask(by id: String) -> Task? {
        guard let cdTask = storage.fetchTask(by: id) else { return nil }
        let task = Task(cdTask: cdTask)
        return task
    }
}
