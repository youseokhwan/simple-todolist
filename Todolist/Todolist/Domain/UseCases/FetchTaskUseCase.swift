//
//  FetchTaskUseCase.swift
//  Todolist
//
//  Created by Jae Kyeong Ko on 2022/07/12.
//

import Foundation

struct FetchTaskUseCase {
    let taskRepository = TaskRepository()

    func fetchAllTasks(completion: @escaping ([Task]) -> Void) {
        taskRepository.fetchAllTasks() { tasks in
            completion(tasks)
        }
    }

    func fetchTask(by id: String) -> Task? {
        return taskRepository.fetchTask(by: id)
    }
}
