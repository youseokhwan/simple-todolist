//
//  SettingsTableViewCellModel.swift
//  Todolist
//
//  Created by Jae Kyeong Ko on 2022/07/11.
//

import Foundation

struct SettingsTableViewCellModel {
    var cellTitle: String
}

struct SectionOfSettingsTableViewCellModel {
    var headerTitle: String
    var items: [SettingsTableViewCellModel]
}
