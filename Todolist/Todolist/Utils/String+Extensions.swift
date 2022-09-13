//
//  String+Extensions.swift
//  Todolist
//
//  Created by 유석환 on 2022/07/20.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: "Localizable", value: self, comment: "")
    }

    var trimmed: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
