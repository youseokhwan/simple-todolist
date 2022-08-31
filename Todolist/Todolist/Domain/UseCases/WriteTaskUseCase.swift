//
//  WriteTaskUseCase.swift
//  Todolist
//
//  Created by 유석환 on 2022/07/25.
//

import Foundation

struct WriteTaskUseCase {
    private let taskRepository = TaskRepository()

    private func autoIncreasedID() -> Int {
        return UserDefaultsRepository.nextTaskID()
    }

    func createTask(title: String, isDaily: Bool) {
        let task = Task(id: autoIncreasedID(),
                        title: title,
                        isDaily: isDaily,
                        isDone: false,
                        createdDate: Date())

        taskRepository.create(task: task)
    }

    func update(task: Task) {
        taskRepository.update(task: task)
    }

    func updateIsDone(of task: Task, value: Bool) {
        taskRepository.updateIsDone(of: task, value: value)
    }

    func updateIsDoneToFalse(of task: Task) {
        taskRepository.updateIsDoneToFalse(of: task)
    }

    func updateTasksAsOfToday(tasks: [Task]) {
        tasks.forEach { task in
            if !task.isDaily && task.isDone {
                delete(task: task)
            } else {
                updateIsDoneToFalse(of: task)
            }
        }

        UserDefaultsRepository.saveLastFetchDate(value: Date.yearMonthDay)
    }

    func delete(task: Task) {
        taskRepository.delete(task: task)
    }
}
