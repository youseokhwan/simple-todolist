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
    let addTaskUseCase: AddTaskUseCase

    let context: BehaviorRelay<String>
    let isDaily: BehaviorRelay<Bool>

    init() {
        addTaskUseCase = AddTaskUseCase()

        context = BehaviorRelay<String>(value: "")
        isDaily = BehaviorRelay<Bool>(value: false)
    }

    func addTask() {
        guard !context.value.isEmpty else { return }

        addTaskUseCase.createTask(context: context.value, isDaily: isDaily.value)
    }
}
