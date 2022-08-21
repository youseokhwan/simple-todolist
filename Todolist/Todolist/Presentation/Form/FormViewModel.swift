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
    private let writeTaskUseCase: WriteTaskUseCase

    let taskID: BehaviorRelay<Int>
    let title: BehaviorRelay<String>
    let publishedDate: BehaviorRelay<String>
    let isDaily: BehaviorRelay<Bool>
    let isChecked: BehaviorRelay<Bool>

    init() {
        writeTaskUseCase = WriteTaskUseCase()

        taskID = BehaviorRelay(value: Const.tempIDForNewTask)
        title = BehaviorRelay(value: "")
        publishedDate = BehaviorRelay(value: Date.today)
        isDaily = BehaviorRelay(value: false)
        isChecked = BehaviorRelay(value: false)
    }

    func saveTask() {
        guard !title.value.isEmpty else { return }

        if taskID.value == Const.tempIDForNewTask {
            writeTaskUseCase.createTask(title: title.value, isDaily: isDaily.value)
        } else {
            let task = Task(id: taskID.value,
                            title: title.value,
                            isDaily: isDaily.value,
                            isChecked: isChecked.value)

            writeTaskUseCase.update(task: task)
        }
    }
}
