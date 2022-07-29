//
//  SettingsViewModel.swift
//  Todolist
//
//  Created by 유석환 on 2022/06/24.
//

import Foundation

import RxRelay

final class SettingsViewModel {
    let items: [SettingsSection]
    let appearence: BehaviorRelay<Int>

    init() {
        items = [SettingsSection(title: Const.appSettingsSection,
                                 items: [Const.themeSettings]),
                 SettingsSection(title: Const.informationSection,
                                 items: [Const.openSourceLicense,
                                         Const.versionInfomation,
                                         Const.patchDetails,
                                         Const.contactUs])]
        appearence = BehaviorRelay(value: UserDefaultsRepository.currentAppearance())
    }
}
