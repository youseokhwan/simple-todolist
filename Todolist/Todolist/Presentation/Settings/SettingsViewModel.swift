//
//  SettingsViewModel.swift
//  Todolist
//
//  Created by 유석환 on 2022/06/24.
//

import Foundation

final class SettingsViewModel {
    let items = [
        SettingsTableViewCellModel(
            title: "설정",
            items: ["테마 설정"]
        ),
        SettingsTableViewCellModel(
            title: "앱 정보",
            items: ["오픈소스 라이센스", "버전 정보", "수정사항", "Contact Us"]
        )
    ]
}
