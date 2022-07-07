//
//  TasksViewModel.swift
//  Todolist
//
//  Created by 유석환 on 2022/06/24.
//

import Foundation

import RxSwift

final class TasksViewModel {
    var delegate: TasksViewModelDelegate?
    let tasksObserver: Observable<[Task]> = Observable
        .just([Task(id: "0", context: "첫번째 할일", isDaily: false, isChecked: false),
               Task(id: "1", context: "두번째 할일", isDaily: false, isChecked: false),
               Task(id: "2", context: "세번째 할일", isDaily: false, isChecked: false)])
    
    func didTappedFormButton() {
        delegate?.didTappedFormButton()
    }
    
    func didTappedSettingsButton() {
        delegate?.didTappedSettingsButton()
    }
}
