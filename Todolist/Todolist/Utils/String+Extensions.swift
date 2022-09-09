//
//  String+Extensions.swift
//  Todolist
//
//  Created by 유석환 on 2022/07/20.
//

import Foundation

extension String {
    static func text(_ key: String) -> String {
        guard let path = Bundle.main.path(forResource: "Text", ofType: "plist") else { return "" }

        let url = URL(fileURLWithPath: path)

        guard let data = try? Data(contentsOf: url),
              let plist = try? PropertyListSerialization.propertyList(
                from: data,
                options: .mutableContainers,
                format: nil
              ) as? [String: String],
              let value = plist[key] else { return "" }

        return value
    }

    var localized: String {
        return NSLocalizedString(self, tableName: "Localizable", value: self, comment: "")
    }

    var trimmed: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
