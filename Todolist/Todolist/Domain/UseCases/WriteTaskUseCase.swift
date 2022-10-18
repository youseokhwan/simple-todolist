//
//  WriteTaskUseCase.swift
//  Todolist
//
//  Created by 유석환 on 2022/07/25.
//

import Foundation

struct WriteTaskUseCase {
    static let taskCreated = Notification.Name("taskCreated")

    private let taskRepository = TaskRepository()

    private func autoIncreasedID() -> Int {
        return UserDefaultsRepository.nextTaskID()
    }

    func createTask(title: String, isDone: Bool, isDaily: Bool, createdDate: Date) {
        let task = Task(id: autoIncreasedID(),
                        title: title,
                        isDone: isDone,
                        isDaily: isDaily,
                        createdDate: createdDate)

        taskRepository.create(task: task)
        NotificationCenter.default.post(name: Self.taskCreated,
                                        object: nil,
                                        userInfo: ["newTask": task])
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

    func moveTask(at sourceRow: Int, to destinationRow: Int) {
        taskRepository.moveTask(at: sourceRow, to: destinationRow)
    }
}
