//
//  AddTaskUseCase.swift
//  Todolist
//
//  Created by 유석환 on 2022/07/07.
//

import Foundation

struct AddTaskUseCase {
    private let taskRepository = TaskRepository()

    func createTask(context: String, isDaily: Bool) {
        let task = Task(id: autoIncreasedID(), context: context, isDaily: isDaily, isChecked: false)

        taskRepository.create(task: task)
    }

    func autoIncreasedID() -> String {
        return UserDefaultsRepository.nextTaskID()
    }
}
