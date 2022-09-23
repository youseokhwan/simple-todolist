//
//  String+Extensions.swift
//  Todolist
//
//  Created by 유석환 on 2022/07/20.
//

import Foundation

extension String {
    init(_ buttonTitle: ButtonTitle) {
        self.init(buttonTitle.rawValue)
    }

    init(_ labelText: LabelText) {
        self.init(labelText.rawValue)
    }

    init(_ settingsText: SettingsText) {
        self.init(settingsText.rawValue)
    }

    var trimmed: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
