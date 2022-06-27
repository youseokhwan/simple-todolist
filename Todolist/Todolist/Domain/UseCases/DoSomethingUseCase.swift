//
//  DoSomethingUseCase.swift
//  Todolist
//
//  Created by 유석환 on 2022/06/24.
//

import Foundation

// Dummy UseCase
struct DoSomethingUseCase {
    var taskRepository = TaskRepository()

    func fetchAllTasks(by userID: String) {
        taskRepository.fetchAllTasks(by: userID)
    }

    func add(task: Task) {
        taskRepository.add(task: task)
    }

    // ...
}
