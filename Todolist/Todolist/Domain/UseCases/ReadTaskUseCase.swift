//
//  ReadTaskUseCase.swift
//  Todolist
//
//  Created by Jae Kyeong Ko on 2022/07/12.
//

import Foundation

import RealmSwift

struct ReadTaskUseCase {
    private let taskRepository = TaskRepository()

    func allTasks() -> [Task] {
        return taskRepository.allTasks()
    }

    func orderOfTasksResults() -> Results<OrderOfTasks>? {
        return taskRepository.orderOfTasksResults()
    }
}
