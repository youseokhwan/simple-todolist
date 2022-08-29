//
//  Date+Extensions.swift
//  Todolist
//
//  Created by Jae Kyeong Ko on 2022/07/05.
//

import Foundation

extension Date {
    static var today: String {
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = Const.yyyyMMdd

        return dateFormatter.string(from: Date())
    }

    static var weekOfToday: String {
        let date = Date()
        let month = Calendar.current.component(.month, from: date)
        let day = Calendar.current.component(.day, from: date)
        let weekdays = [1: Const.sunday,
                        2: Const.monday,
                        3: Const.tuesday,
                        4: Const.wednesday,
                        5: Const.thursday,
                        6: Const.friday,
                        7: Const.saturday]
        let weekdayRawValue = Calendar.current.component(.weekday, from: date)

        return "\(month).\(day) (\(weekdays[weekdayRawValue] ?? ""))"
    }
}
