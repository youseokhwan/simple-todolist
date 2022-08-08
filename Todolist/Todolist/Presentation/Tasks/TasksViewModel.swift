//
//  TasksViewModel.swift
//  Todolist
//
//  Created by 유석환 on 2022/06/24.
//

import Foundation

import RxRelay

final class TasksViewModel {
    private let fetchTaskUseCase: FetchTaskUseCase
    private let updateTaskUseCase: UpdateTaskUseCase

    let allTasks: BehaviorRelay<[Task]>

    var delegate: TasksViewModelDelegate?

    init() {
        fetchTaskUseCase = FetchTaskUseCase()
        updateTaskUseCase = UpdateTaskUseCase()

        allTasks = BehaviorRelay(value: [])
    }

    private func isFirstFetchOfToday() -> Bool {
        let lastFetchDate = UserDefaultsRepository.lastFetchDate()
        let todayDate = Date.today

        return lastFetchDate < todayDate
    }

    func fetchAllTasks() {
        var tasks = fetchTaskUseCase.fetchAllTasks()

        if isFirstFetchOfToday() {
            tasks = updateTaskUseCase.updatedTasksAsOfToday(tasks: tasks)
        }

        allTasks.accept(tasks)
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

    func didTappedFormButton() {
        delegate?.didTappedFormButton()
    }

    func didTappedSettingsButton() {
        delegate?.didTappedSettingsButton()
    }
}
