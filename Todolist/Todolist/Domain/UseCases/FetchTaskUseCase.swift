//
//  FetchTaskUseCase.swift
//  Todolist
//
//  Created by Jae Kyeong Ko on 2022/07/12.
//

import Foundation

struct FetchTaskUseCase {
    private let taskRepository = TaskRepository()

    func fetchAllTasks(completion: @escaping ([Task]) -> Void) {
        taskRepository.fetchAllTasks() { tasks in
            completion(tasks)
        }
    }

    func fetchTask(by id: String, completion: @escaping (Task?) -> Void) {
        taskRepository.fetchTask(by: id) { task in
            completion(task)
        }
    }
}
