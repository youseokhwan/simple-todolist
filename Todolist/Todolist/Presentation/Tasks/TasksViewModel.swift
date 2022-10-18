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
    private let disposeBag: DisposeBag

    let allTasks: BehaviorRelay<[Task]>

    init() {
        readTaskUseCase = ReadTaskUseCase()
        writeTaskUseCase = WriteTaskUseCase()
        disposeBag = DisposeBag()

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

        var updatedTasks = allTasks.value

        updatedTasks[index] = updatedTask
        allTasks.accept(updatedTasks)
    }

    @objc
    func deleteTask(_ notification: Notification) {
        guard let deletedTask = notification.userInfo?["deletedTask"] as? Task,
              let index = allTasks.value.firstIndex(of: deletedTask) else { return }

        var deletedTasks = allTasks.value

        deletedTasks.remove(at: index)
        allTasks.accept(deletedTasks)
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
        let removedTask = allTasks.value[index]

        writeTaskUseCase.delete(task: removedTask)
    }

    func moveTask(at sourceRow: Int, to destinationRow: Int) {
        writeTaskUseCase.moveTask(at: sourceRow, to: destinationRow)
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
        var orderedTasks = [Task]()

        for id in orderOfTasks {
            guard let task = tasks.first(where: { $0.id == id }) else { continue }

            orderedTasks.append(task)
        }

        allTasks.accept(orderedTasks)
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
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(deleteTask(_:)),
                                               name: WriteTaskUseCase.taskDeleted,
                                               object: nil)
    }
}
