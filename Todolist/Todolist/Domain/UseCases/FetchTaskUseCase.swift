//
//  FetchTaskUseCase.swift
//  Todolist
//
//  Created by Jae Kyeong Ko on 2022/07/12.
//

import Foundation

import RealmSwift

struct FetchTaskUseCase {
    private let taskRepository = TaskRepository()

    func taskResults() -> Results<Task>? {
        return taskRepository.taskResults()
    }
}
