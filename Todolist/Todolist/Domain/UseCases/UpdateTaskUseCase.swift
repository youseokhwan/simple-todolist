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

    func update(tasks: [Task]) {
        taskRepository.update(tasks: tasks)
    }

    func updateIsChecked(of task: Task, value: Bool) {
        taskRepository.updateIsChecked(of: task, value: value)
    }

    func delete(task: Task) {
        taskRepository.delete(task: task)
    }

    func updatedTasksAsOfToday(tasks: [Task]) -> [Task] {
        var updatedTasks = tasks

        tasks.forEach { task in
            if !task.isDaily && task.isChecked {
                updatedTasks = updatedTasks.filter { $0.id != task.id }
                delete(task: task)
            }
        }

        updatedTasks = updatedTasks.map {
            Task(id: $0.id, context: $0.context, isDaily: $0.isDaily, isChecked: false)
        }
        update(tasks: updatedTasks)

        UserDefaultsRepository.saveLastFetchDate(value: Date.today)

        return updatedTasks
    }
}
