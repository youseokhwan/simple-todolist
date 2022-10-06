//
//  TasksViewModel.swift
//  Todolist
//
//  Created by 유석환 on 2022/06/24.
//

import Foundation

import RxRealm
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
    func updateTasksAsOfToday() {
        if isFirstFetchOfToday() {
            writeTaskUseCase.updateTasksAsOfToday(tasks: allTasks.value)
        }
    }

    func updateIsDone(of task: Task, value: Bool) {
        writeTaskUseCase.updateIsDone(of: task, value: value)
    }

    func deleteTask(of index: Int) {
        var newAllTasks = allTasks.value
        let removedTask = newAllTasks.remove(at: index)

        allTasks.accept(newAllTasks)
        writeTaskUseCase.delete(task: removedTask)
    }

    func moveTask(at sourceRow: Int, to destinationRow: Int) {
        writeTaskUseCase.moveTask(at: sourceRow, to: destinationRow)
    }
}

private extension TasksViewModel {
    func configure() {
        configureBind()
    }

    func configureBind() {
        if let results = readTaskUseCase.taskResults() {
            Observable.changeset(from: results)
                .subscribe(onNext: { [weak self] collection, _ in
                    let tasks = collection.toArray()

                    self?.allTasks.accept(tasks)
                })
                .disposed(by: disposeBag)
        }
    }
}
