//
//  Task.swift
//  Todolist
//
//  Created by 유석환 on 2022/06/24.
//

import Foundation

struct Task {
    let id: String
    var publishedDate: Date
    var endDate: Date?
    var context: String
    var isChecked: Bool
}
