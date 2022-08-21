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

    let id: BehaviorRelay<Int>
    let title: BehaviorRelay<String>
    let isDaily: BehaviorRelay<Bool>
    let isDone: BehaviorRelay<Bool>

    init() {
        writeTaskUseCase = WriteTaskUseCase()

        id = BehaviorRelay(value: Const.tempIDForNewTask)
        title = BehaviorRelay(value: "")
        isDaily = BehaviorRelay(value: false)
        isDone = BehaviorRelay(value: false)
    }

    func saveTask() {
        guard !title.value.isEmpty else { return }

        if id.value == Const.tempIDForNewTask {
            writeTaskUseCase.createTask(title: title.value, isDaily: isDaily.value)
        } else {
            let task = Task(id: id.value,
                            title: title.value,
                            isDaily: isDaily.value,
                            isDone: isDone.value)

            writeTaskUseCase.update(task: task)
        }
    }
}
