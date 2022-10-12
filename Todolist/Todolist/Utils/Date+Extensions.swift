//
//  Date+Extensions.swift
//  Todolist
//
//  Created by Jae Kyeong Ko on 2022/07/05.
//

import Foundation

extension Date {
    static var yearMonthDay: String {
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "yyyy.MM.dd"
        dateFormatter.locale = Locale(identifier: Locale.preferredLanguages[0])
        dateFormatter.timeZone = TimeZone(identifier: TimeZone.current.identifier)

        return dateFormatter.string(from: Date())
    }

    static var monthDayWeekday: String {
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "M.dd (E)"
        dateFormatter.locale = Locale(identifier: Locale.preferredLanguages[0])
        dateFormatter.timeZone = TimeZone(identifier: TimeZone.current.identifier)

        return dateFormatter.string(from: Date())
    }
}
