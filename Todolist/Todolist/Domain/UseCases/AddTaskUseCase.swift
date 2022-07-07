//
//  AddTaskUseCase.swift
//  Todolist
//
//  Created by 유석환 on 2022/07/07.
//

import Foundation

struct AddTaskUseCase {
    var repository = TaskRepository()

    func createTask(context: String, isDaily: Bool) {
        let task = Task(id: "0", // TODO: auto increment
                        context: context,
                        isDaily: isDaily,
                        isChecked: false)

        repository.create(task: task)
    }
}
