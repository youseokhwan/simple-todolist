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
        items = [.ThemeCell(title: "설정",
                            items: [.ThemeItem(title: "테마 설정", currentTheme: "light")]),
                 .DefaultCell(title: "앱 정보",
                              items: [.DefaultItem(title: "오픈소스 라이센스"),
                                      .DefaultItem(title: "버전 정보"),
                                      .DefaultItem(title: "수정사항"),
                                      .DefaultItem(title: "Contact Us")])]
    }
}
