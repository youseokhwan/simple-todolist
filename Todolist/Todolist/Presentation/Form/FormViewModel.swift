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
    static let tempIDForNewTask = -1

    private let writeTaskUseCase: WriteTaskUseCase

    let id: BehaviorRelay<Int>
    let title: BehaviorRelay<String>
    let isDone: BehaviorRelay<Bool>
    let isDaily: BehaviorRelay<Bool>
    let createdDate: BehaviorRelay<Date>

    init() {
        writeTaskUseCase = WriteTaskUseCase()

        id = BehaviorRelay(value: Self.tempIDForNewTask)
        title = BehaviorRelay(value: "")
        isDone = BehaviorRelay(value: false)
        isDaily = BehaviorRelay(value: false)
        createdDate = BehaviorRelay(value: Date())
    }

    func saveTask() {
        guard !title.value.isEmpty else { return }

        if id.value == Self.tempIDForNewTask {
            writeTaskUseCase.createTask(title: title.value.trimmed,
                                        isDone: isDone.value,
                                        isDaily: isDaily.value,
                                        createdDate: createdDate.value)
        } else {
            let task = Task(id: id.value,
                            title: title.value.trimmed,
                            isDone: isDone.value,
                            isDaily: isDaily.value,
                            createdDate: createdDate.value)

            writeTaskUseCase.update(task: task)
        }
    }
}
