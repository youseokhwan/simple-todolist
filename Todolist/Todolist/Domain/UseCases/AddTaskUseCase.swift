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
        // TODO: Task 인스턴스 생성 후 Repository 메소드 호출
        // TODO: ID auto increment 구현
        print("createTask(context:isDaily:) 호출됨")
    }
}
