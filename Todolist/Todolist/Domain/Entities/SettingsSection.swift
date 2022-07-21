//
//  SettingsSection.swift
//  Todolist
//
//  Created by Jae Kyeong Ko on 2022/07/11.
//

import Foundation

import RxDataSources

enum SettingsSection {
    case DefaultCell(title: String, items: [SectionItem])
    case ThemeCell(title: String, items: [SectionItem])
}

extension SettingsSection: SectionModelType {
    var items: [SectionItem] {
        switch self {
        case .DefaultCell(title: _, items: let items):
            return items.map { $0 }
        case .ThemeCell(title: _, items: let items):
            return items.map { $0 }
        }
    }

    var title: String {
        switch self {
        case .DefaultCell(title: let title, items: _):
            return title
        case .ThemeCell(title: let title, items: _):
            return title
        }
    }

    init(original: SettingsSection, items: [SectionItem]) {
        switch original {
        case let .DefaultCell(title, _):
            self = .DefaultCell(title: title, items: items)
        case let .ThemeCell(title, _):
            self = .ThemeCell(title: title, items: items)
        }
    }
}
