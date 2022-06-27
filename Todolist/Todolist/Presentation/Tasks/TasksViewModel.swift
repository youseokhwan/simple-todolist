//
//  TasksViewModel.swift
//  Todolist
//
//  Created by 유석환 on 2022/06/24.
//

import Foundation

final class TasksViewModel {
    var delegate: TasksViewModelDelegate?
    
    func didTappedFormButton() {
        delegate?.didTappedFormButton()
    }
    
    func didTappedSettingsButton() {
        delegate?.didTappedSettingsButton()
    }
    
    var currentDate: String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.string(from: date)
    }
}
