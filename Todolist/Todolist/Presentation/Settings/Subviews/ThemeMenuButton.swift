//
//  MenuButton.swift
//  Todolist
//
//  Created by Jae Kyeong Ko on 2022/07/23.
//

import UIKit

@available(iOS 14.0, *)
final class ThemeMenuButton: UIButton {
    convenience init(handler: @escaping (Int) -> Void) {
        self.init()
        configure(handler: handler)
    }
}

@available(iOS 14.0, *)
private extension ThemeMenuButton {
    func configure(handler: @escaping (Int) -> Void) {
        let currentAppearance = UserDefaultsRepository.currentAppearance()
        let themes = [Const.systemTheme, Const.lightTheme, Const.darkTheme]
        let children = themes.enumerated().map { index, value in
            return UIAction(title: value) { [weak self] action in
                handler(index)
                self?.setTitle(value, for: .normal)
                self?.sizeToFit()
            }
        }

        menu = UIMenu(title: Const.themeMenuTitle,
                      options: .displayInline,
                      children: children)
        showsMenuAsPrimaryAction = true

        setTitle(themes[currentAppearance], for: .normal)
        setTitleColor(.systemBlue, for: .normal)
        sizeToFit()
    }
}
