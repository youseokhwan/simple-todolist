//
//  FormViewModel.swift
//  Todolist
//
//  Created by 유석환 on 2022/06/24.
//

import Foundation

import RxRelay
import RxSwift

final class FormViewModel {
    var context: BehaviorRelay<String>
    var isDaily: BehaviorRelay<Bool>

    let addTaskUseCase: AddTaskUseCase

    init() {
        context = BehaviorRelay<String>(value: "")
        isDaily = BehaviorRelay<Bool>(value: false)

        addTaskUseCase = AddTaskUseCase()
    }

    func addTask() {
        guard !context.value.isEmpty else { return }

        addTaskUseCase.createTask(context: context.value, isDaily: isDaily.value)
    }
}
