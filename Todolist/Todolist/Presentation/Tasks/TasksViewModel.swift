//
//  TasksViewModel.swift
//  Todolist
//
//  Created by 유석환 on 2022/06/24.
//

import Foundation

import RxRelay
import RxSwift

final class TasksViewModel {
    private let readTaskUseCase: ReadTaskUseCase
    private let writeTaskUseCase: WriteTaskUseCase

    let allTasks: BehaviorRelay<[Task]>

    init() {
        readTaskUseCase = ReadTaskUseCase()
        writeTaskUseCase = WriteTaskUseCase()

        allTasks = BehaviorRelay(value: [])

        configure()
    }

    private func isFirstFetchOfToday() -> Bool {
        let lastFetchDate = UserDefaultsRepository.lastFetchDate()
        let todayDate = Date.yearMonthDay

        return lastFetchDate < todayDate
    }

    @objc
    func createTask(_ notification: Notification) {
        guard let createdTask = notification.userInfo?["createdTask"] as? Task else { return }

        allTasks.accept(allTasks.value + [createdTask])
    }

    @objc
    func updateTask(_ notification: Notification) {
        guard let updatedTask = notification.userInfo?["updatedTask"] as? Task,
              let index = allTasks.value.firstIndex(of: updatedTask) else { return }

        var newTasks = allTasks.value

        newTasks[index] = updatedTask
        allTasks.accept(newTasks)
    }

    @objc
    func updateTasksAsOfToday() {
        if isFirstFetchOfToday() {
            writeTaskUseCase.updateTasksAsOfToday(tasks: allTasks.value)
        }
    }

    func updateIsDone(of task: Task, value: Bool) {
        writeTaskUseCase.updateIsDone(of: task, value: value)
    }

    func deleteTask(of index: Int) {
        var newTasks = allTasks.value
        let deletedTask = newTasks.remove(at: index)

        allTasks.accept(newTasks)
        writeTaskUseCase.delete(task: deletedTask)
    }

    func moveTask(at sourceIndex: Int, to destinationIndex: Int) {
        var newTasks = allTasks.value
        let movedTask = newTasks.remove(at: sourceIndex)

        newTasks.insert(movedTask, at: destinationIndex)
        allTasks.accept(newTasks)
        writeTaskUseCase.moveTask(at: sourceIndex, to: destinationIndex)
    }
}

private extension TasksViewModel {
    func configure() {
        configureValues()
        configureBind()
    }

    func configureValues() {
        let tasks = readTaskUseCase.allTasks()
        let orderOfTasks = readTaskUseCase.orderOfTasks()

        allTasks.accept(tasks.sorted(orderOfTasks))
    }

    func configureBind() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(createTask(_:)),
                                               name: WriteTaskUseCase.taskCreated,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateTask(_:)),
                                               name: WriteTaskUseCase.taskUpdated,
                                               object: nil)
    }
}
