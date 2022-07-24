//
//  SettingsSection.swift
//  Todolist
//
//  Created by Jae Kyeong Ko on 2022/07/11.
//

import Foundation

import RxDataSources

struct SettingsSection {
    var title: String
    var items: [String]
}

extension SettingsSection: SectionModelType {
    init(original: SettingsSection, items: [String]) {
        self = original
        self.items = items
    }
}
