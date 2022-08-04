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
        let todayDate = Date().todayDate

        return lastFetchDate < todayDate
    }

    func fetchAllTasks() {
        if isFirstFetchOfToday() {
            // TODO: tasks 최신화 로직 실행
        } else {
            fetchTaskUseCase.fetchAllTasks() { [weak self] tasks in
                self?.allTasks.accept(tasks)
            }
        }
    }

    func deleteTask(of index: Int) {
        var newAllTasks = allTasks.value
        let removedTask = newAllTasks.remove(at: index)

        allTasks.accept(newAllTasks)
        updateTaskUseCase.delete(task: removedTask)
    }

    func update(task: Task?) {
        guard let task = task else { return }
        
        updateTaskUseCase.update(task: task)
    }

    func didTappedFormButton() {
        delegate?.didTappedFormButton()
    }

    func didTappedSettingsButton() {
        delegate?.didTappedSettingsButton()
    }
}
