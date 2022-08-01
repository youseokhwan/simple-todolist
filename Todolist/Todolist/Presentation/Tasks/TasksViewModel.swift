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
    private let deleteTaskUseCase: DeleteTaskUseCase
    private let updateTaskUseCase: UpdateTaskUseCase

    let allTasks: BehaviorRelay<[Task]>

    var delegate: TasksViewModelDelegate?

    init() {
        fetchTaskUseCase = FetchTaskUseCase()
        deleteTaskUseCase = DeleteTaskUseCase()
        updateTaskUseCase = UpdateTaskUseCase()

        allTasks = BehaviorRelay(value: [])
    }

    func fetchAllTasks() {
        fetchTaskUseCase.fetchAllTasks() { [weak self] tasks in
            self?.allTasks.accept(tasks)
        }
    }

    func deleteTask(of index: Int) {
        var newAllTasks = allTasks.value
        let removedTask = newAllTasks.remove(at: index)

        allTasks.accept(newAllTasks)
        deleteTaskUseCase.delete(task: removedTask)
    }

    func updateTask(task: Task?) {
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
