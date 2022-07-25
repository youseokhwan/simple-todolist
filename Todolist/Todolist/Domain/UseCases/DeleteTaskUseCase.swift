//
//  DeleteTaskUseCase.swift
//  Todolist
//
//  Created by 유석환 on 2022/07/25.
//

import Foundation

struct DeleteTaskUseCase {
    private let taskRepository = TaskRepository()

    func delete(task: Task) {
        taskRepository.delete(task: task)
    }
}
