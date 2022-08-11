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

    func updateIsChecked(of task: Task, value: Bool) {
        taskRepository.updateIsChecked(of: task, value: value)
    }

    func updateIsCheckedToFalse(of task: Task) {
        taskRepository.updateIsCheckedToFalse(of: task)
    }

    func delete(task: Task) {
        taskRepository.delete(task: task)
    }

    func updateTasksAsOfToday(tasks: [Task]) {
        tasks.forEach { task in
            if !task.isDaily && task.isChecked {
                delete(task: task)
            } else {
                updateIsCheckedToFalse(of: task)
            }
        }

        UserDefaultsRepository.saveLastFetchDate(value: Date.today)
    }
}
