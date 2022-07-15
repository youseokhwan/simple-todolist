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
    let allTasks: BehaviorRelay<[Task]>
    var delegate: TasksViewModelDelegate?

    init() {
        fetchTaskUseCase = FetchTaskUseCase()
        allTasks = BehaviorRelay(value: [])

        fetchAllTasks()
    }

    private func fetchAllTasks() {
        allTasks.accept(fetchTaskUseCase.fetchAllTasks())
    }

    func didTappedFormButton() {
        delegate?.didTappedFormButton()
    }
    
    func didTappedSettingsButton() {
        delegate?.didTappedSettingsButton()
    }
}
