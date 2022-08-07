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
}
