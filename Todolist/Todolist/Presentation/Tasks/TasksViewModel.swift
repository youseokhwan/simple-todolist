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
    private let fetchTaskUseCase: FetchTaskUseCase
    private let updateTaskUseCase: UpdateTaskUseCase
    private let disposeBag: DisposeBag

    let allTasks: BehaviorRelay<[Task]>

    init() {
        fetchTaskUseCase = FetchTaskUseCase()
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

    func fetchAllTasks() {
//        var tasks = fetchTaskUseCase.fetchAllTasks()
//
//        if isFirstFetchOfToday() {
//            tasks = updateTaskUseCase.updatedTasksAsOfToday(tasks: tasks)
//        }
//
//        allTasks.accept(tasks)
    }

    func deleteTask(of index: Int) {
        var newAllTasks = allTasks.value
        let removedTask = newAllTasks.remove(at: index)

        allTasks.accept(newAllTasks)
        updateTaskUseCase.delete(task: removedTask)
    }

    func updateIsChecked(of task: Task, value: Bool) {
        updateTaskUseCase.updateIsChecked(of: task, value: value)
    }
}

private extension TasksViewModel {
    func configure() {
        configureBind()
    }

    func configureBind() {
        if let results = fetchTaskUseCase.taskResults() {
            Observable.changeset(from: results)
                .subscribe(onNext: { [weak self] collection, _ in
                    let tasks = Array(collection)

                    self?.allTasks.accept(tasks)
                })
                .disposed(by: disposeBag)
        }
    }
}
