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
    var items: [SectionItem]
}

extension SettingsSection: SectionModelType {
    init(original: SettingsSection, items: [SectionItem]) {
        self = original
        self.items = items
    }
}
