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
    private let addTaskUseCase: AddTaskUseCase
    private let updateTaskUseCase: UpdateTaskUseCase

    let taskID: BehaviorRelay<Int>
    let context: BehaviorRelay<String>
    let publishedDate: BehaviorRelay<String>
    let isDaily: BehaviorRelay<Bool>
    let isChecked: BehaviorRelay<Bool>

    init() {
        addTaskUseCase = AddTaskUseCase()
        updateTaskUseCase = UpdateTaskUseCase()

        taskID = BehaviorRelay(value: Const.tempIDForNewTask)
        context = BehaviorRelay(value: "")
        publishedDate = BehaviorRelay(value: Date.todayDate)
        isDaily = BehaviorRelay(value: false)
        isChecked = BehaviorRelay(value: false)
    }

    func saveTask() {
        guard !context.value.isEmpty else { return }

        if taskID.value == Const.tempIDForNewTask {
            addTaskUseCase.createTask(context: context.value, isDaily: isDaily.value)
        } else {
            let task = Task(id: taskID.value,
                            context: context.value,
                            isDaily: isDaily.value,
                            isChecked: isChecked.value)

            updateTaskUseCase.update(task: task)
        }
    }
}
