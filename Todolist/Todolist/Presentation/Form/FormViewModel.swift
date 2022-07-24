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
    let updateTaskUseCase: UpdateTaskUseCase

    let taskID: BehaviorRelay<String>
    let context: BehaviorRelay<String>
    let isDaily: BehaviorRelay<Bool>

    init() {
        addTaskUseCase = AddTaskUseCase()
        updateTaskUseCase = UpdateTaskUseCase()

        taskID = BehaviorRelay(value: "")
        context = BehaviorRelay(value: "")
        isDaily = BehaviorRelay(value: false)
    }

    func saveTask() {
        guard !context.value.isEmpty else { return }

        if taskID.value.isEmpty {
            addTaskUseCase.createTask(context: context.value, isDaily: isDaily.value)
        } else {
            let task = Task(id: taskID.value,
                            context: context.value,
                            isDaily: isDaily.value,
                            isChecked: false)

            updateTaskUseCase.update(task: task)
        }
    }
}
