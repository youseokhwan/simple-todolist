//
//  FetchTaskUseCase.swift
//  Todolist
//
//  Created by Jae Kyeong Ko on 2022/07/12.
//

import Foundation

struct FetchTaskUseCase {
    let taskRepository = TaskRepository()

    func fetchAllTasks() -> [Task] {
        let cdTasks = taskRepository.fetchAllTasks()
        var tasks = [Task]()

        cdTasks.forEach { cdTask in
            guard let id = cdTask.id,
                  let context = cdTask.context else { return }
            let task = Task(
                id: id,
                context: context,
                isDaily: cdTask.isDaily,
                isChecked: cdTask.isChecked
            )

            tasks.append(task)
        }

        return tasks
    }

    func fetchTask(id: String) -> Task? {
        guard let cdTask = taskRepository.fetchTask(id: id),
              let id = cdTask.id,
              let context = cdTask.context else { return nil }
        let task = Task(
            id: id,
            context: context,
            isDaily: cdTask.isDaily,
            isChecked: cdTask.isChecked
        )
        return task
    }
}
