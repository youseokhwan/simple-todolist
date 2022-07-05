//
//  Date+Extensions.swift
//  Todolist
//
//  Created by Jae Kyeong Ko on 2022/07/05.
//

import Foundation

extension Date {
    var todayDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.string(from: self)
    }
}
