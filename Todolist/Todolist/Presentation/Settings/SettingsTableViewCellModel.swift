//
//  SettingsTableViewCellModel.swift
//  Todolist
//
//  Created by Jae Kyeong Ko on 2022/07/11.
//

import Foundation

import RxDataSources

struct SettingsTableViewCellModel {
    var headerTitle: String
    var items: [String]
}

extension SettingsTableViewCellModel: SectionModelType {
    var identity: String {
        return headerTitle
    }
    
    init(original: SettingsTableViewCellModel, items: [String]) {
        self = original
        self.items = items
    }
}
