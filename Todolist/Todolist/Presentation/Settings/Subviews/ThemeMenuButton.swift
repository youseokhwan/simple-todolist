//
//  MenuButton.swift
//  Todolist
//
//  Created by Jae Kyeong Ko on 2022/07/23.
//

import UIKit

final class ThemeMenuButton: UIButton {
    var themes: [String] {
        [Const.systemTheme, Const.lightTheme, Const.darkTheme]
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

private extension ThemeMenuButton {
    func configure() {
        configureViews()
    }

    func configureViews() {
        let currentAppearance = UserDefaultsRepository.currentAppearance()

        setTitle(themes[currentAppearance], for: .normal)
        setTitleColor(.systemBlue, for: .normal)
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

            menu = UIMenu(title: Const.themeMenuTitle, options: .displayInline, children: children)
            showsMenuAsPrimaryAction = true
        }
    }
}
