//
//  UpdateTaskUseCase.swift
//  Todolist
//
//  Created by 유석환 on 2022/07/25.
//

import Foundation

struct UpdateTaskUseCase {
    private let taskRepository = TaskRepository()

    func update(task: Task) {
        taskRepository.update(task: task)
    }

    func updateIsChecked(of task: Task, value: Bool) {
        taskRepository.updateIsChecked(of: task, value: value)
    }

    func delete(task: Task) {
        taskRepository.delete(task: task)
    }

//    func updateTasksAsOfToday(completion: @escaping ([Task]) -> Void) {
//        taskRepository.updateTasksAsOfToday { updatedTasks in
//            completion(updatedTasks)
//            UserDefaultsRepository.saveLastFetchDate(value: Date.todayDate)
//        }
//    }
}
