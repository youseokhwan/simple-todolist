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

    var year: String {
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "yyyy"

        return dateFormatter.string(from: self)
    }

    var month: String {
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "MM"

        return dateFormatter.string(from: self)
    }

    var day: String {
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "dd"

        return dateFormatter.string(from: self)
    }
}
