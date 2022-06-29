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
    var currentDate: String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.string(from: date)
    }
    let tasksObserver: Observable<[Task]> = Observable
        .of([Task(id: "0", publishedDate: Date(), context: "첫번째 할일", isChecked: false),
               Task(id: "1", publishedDate: Date(), context: "두번째 할일", isChecked: false),
               Task(id: "2", publishedDate: Date(), endDate: Date(), context: "세번째 할일", isChecked: false)])
    
    func didTappedFormButton() {
        delegate?.didTappedFormButton()
    }
    
    func didTappedSettingsButton() {
        delegate?.didTappedSettingsButton()
    }
}
