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
        items = [.ThemeCell(title: Const.appSettingsSection,
                            items: [.ThemeItem(title: Const.themeSettings, currentTheme: "light")]),
                 .DefaultCell(title: Const.informationSection,
                              items: [.DefaultItem(title: Const.openSourceLicense),
                                      .DefaultItem(title: Const.versionInfomation),
                                      .DefaultItem(title: Const.patchDetails),
                                      .DefaultItem(title: Const.contactUs)])]
    }
}
