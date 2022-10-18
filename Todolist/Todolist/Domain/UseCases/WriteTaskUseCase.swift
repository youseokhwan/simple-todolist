//
//  WriteTaskUseCase.swift
//  Todolist
//
//  Created by 유석환 on 2022/07/25.
//

import Foundation

struct WriteTaskUseCase {
    static let taskCreated = Notification.Name("taskCreated")
    static let taskUpdated = Notification.Name("taskUpdated")

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
        NotificationCenter.default.post(name: Self.taskUpdated,
                                        object: nil,
                                        userInfo: ["updatedTask": task])
    }

    func updateIsDone(of task: Task, value: Bool) {
        let updatedTask = Task(id: task.id,
                               title: task.title,
                               isDone: value,
                               isDaily: task.isDaily,
                               createdDate: task.createdDate)

        update(task: updatedTask)
    }

    func updateTasksAsOfToday(tasks: [Task]) {
        tasks.forEach { task in
            if !task.isDaily && task.isDone {
                delete(task: task)
            } else {
                updateIsDone(of: task, value: false)
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
