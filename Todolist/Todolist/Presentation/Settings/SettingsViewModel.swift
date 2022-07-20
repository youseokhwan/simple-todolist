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
        items = [SettingsSection(
                    title: Const.appSettingsSection,
                    items: [Const.themeSettings]
                 ),
                 SettingsSection(
                    title: Const.informationSection,
                    items: [Const.openSourceLicense, Const.versionInfomation,
                            Const.patchDetails, Const.contactUs]
                 )
        ]
    }
}
