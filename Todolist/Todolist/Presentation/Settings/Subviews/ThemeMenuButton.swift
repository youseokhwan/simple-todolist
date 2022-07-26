//
//  MenuButton.swift
//  Todolist
//
//  Created by Jae Kyeong Ko on 2022/07/23.
//

import UIKit

final class ThemeMenuButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
}

private extension ThemeMenuButton {
    func configure() {
        configureViews()
    }

    func configureViews() {
        let currentAppearance = UserDefaultsRepository.currentAppearance()
        let themes = [Const.systemTheme, Const.lightTheme, Const.darkTheme]
        let children = themes.enumerated().map { index, value in
            return UIAction(title: value) { [weak self] action in
                self?.superview?.window?.overrideUserInterfaceStyle = UIUserInterfaceStyle(
                    rawValue: index
                ) ?? .unspecified

                UserDefaultsRepository.saveAppearance(value: index)

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
