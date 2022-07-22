//
//  SettingsViewModel.swift
//  Todolist
//
//  Created by 유석환 on 2022/06/24.
//

import Foundation

final class SettingsViewModel {
    let items: [SettingsSection]

    init() {
        items = [SettingsSection(title: Const.appSettingsSection,
                                 items: [.Theme(title: Const.themeSettings,
                                                currentTheme: Const.lightTheme)]),
                 SettingsSection(title: Const.informationSection,
                                 items: [.Default(title: Const.openSourceLicense),
                                         .Default(title: Const.versionInfomation),
                                         .Default(title: Const.patchDetails),
                                         .Default(title: Const.contactUs)])]
    }
}
