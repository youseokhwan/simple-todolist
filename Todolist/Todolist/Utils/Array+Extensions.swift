//
//  Array+Extensions.swift
//  Todolist
//
//  Created by 유석환 on 2022/10/18.
//

import Foundation

extension Array<Task> {
    func sorted(_ orderOfTasks: [TaskID]) -> Self {
        var orderedTasks = [Task]()

        for id in orderOfTasks {
            guard let task = self.first(where: { $0.id == id }) else { continue }

            orderedTasks.append(task)
        }

        return orderedTasks
    }
}
