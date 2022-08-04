//
//  UpdateTaskUseCase.swift
//  Todolist
//
//  Created by 유석환 on 2022/07/25.
//

import Foundation

struct UpdateTaskUseCase {
    private let taskRepository = TaskRepository()

    func update(task: Task) {
        taskRepository.update(task: task)
    }

    func delete(task: Task) {
        taskRepository.delete(task: task)
    }
}
