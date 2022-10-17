//
//  MenuButton.swift
//  Todolist
//
//  Created by Jae Kyeong Ko on 2022/07/23.
//

import UIKit

final class SettingsThemeMenuButton: UIButton {
    var themes: [String] {
        [String(.systemThemeItem), String(.lightThemeItem), String(.darkThemeItem)]
    }

    convenience init() {
        self.init(frame: CGRect.zero)
        configure()
    }

    convenience init(handler: @escaping (Int) -> Void) {
        self.init()
        configureHandler(handler)
    }
}

private extension SettingsThemeMenuButton {
    func configure() {
        configureViews()
    }

    func configureViews() {
        let currentAppearance = UserDefaultsRepository.currentAppearance()

        setTitle(themes[currentAppearance], for: .normal)
        setTitleColor(.systemBlue, for: .normal)
        titleLabel?.font = UIFont.instance(.theCircleM, size: 18)
        sizeToFit()
    }

    func configureHandler(_ handler: @escaping (Int) -> Void) {
        if #available(iOS 14.0, *) {
            let children = themes.enumerated().map { index, value in
                return UIAction(title: value) { [weak self] action in
                    handler(index)
                    self?.setTitle(value, for: .normal)
                    self?.sizeToFit()
                }
            }

            menu = UIMenu(title: String(.themeMenuTitle),
                          options: .displayInline,
                          children: children)
            showsMenuAsPrimaryAction = true
        }
    }
}
