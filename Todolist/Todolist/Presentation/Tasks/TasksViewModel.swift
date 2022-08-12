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
    private let updateTaskUseCase: UpdateTaskUseCase
    private let disposeBag: DisposeBag

    let allTasks: BehaviorRelay<[Task]>

    init() {
        readTaskUseCase = ReadTaskUseCase()
        updateTaskUseCase = UpdateTaskUseCase()
        disposeBag = DisposeBag()

        allTasks = BehaviorRelay(value: [])

        configure()
    }

    private func isFirstFetchOfToday() -> Bool {
        let lastFetchDate = UserDefaultsRepository.lastFetchDate()
        let todayDate = Date.today

        return lastFetchDate < todayDate
    }

    func updateTasksAsOfToday() {
        if isFirstFetchOfToday() {
            updateTaskUseCase.updateTasksAsOfToday(tasks: allTasks.value)
        }
    }

    func updateIsChecked(of task: Task, value: Bool) {
        updateTaskUseCase.updateIsChecked(of: task, value: value)
    }

    func deleteTask(of index: Int) {
        var newAllTasks = allTasks.value
        let removedTask = newAllTasks.remove(at: index)

        allTasks.accept(newAllTasks)
        updateTaskUseCase.delete(task: removedTask)
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
                    let tasks = Array(collection)

                    self?.allTasks.accept(tasks)
                })
                .disposed(by: disposeBag)
        }
    }
}
