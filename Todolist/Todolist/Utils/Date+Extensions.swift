//
//  Date+Extensions.swift
//  Todolist
//
//  Created by Jae Kyeong Ko on 2022/07/05.
//

import Foundation

extension Date {
    static var monthDayWeekday: String {
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "M.dd (E)"

        return dateFormatter.string(from: Date())
    }
}
