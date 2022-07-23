//
//  MenuButton.swift
//  Todolist
//
//  Created by Jae Kyeong Ko on 2022/07/23.
//

import UIKit

final class ThemeButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
}

private extension ThemeButton {
    func configure() {
        configureViews()
    }

    func configureViews() {
        let children = [Const.systemTheme, Const.lightTheme, Const.darkTheme]
            .enumerated()
            .map { index, value in
                return UIAction(title: value) { [weak self] action in
                    self?.superview?.window?.overrideUserInterfaceStyle = UIUserInterfaceStyle(
                        rawValue: index
                    ) ?? .unspecified

                    UserDefaultsRepository.saveAppearance(value: index)

                    self?.setTitle(value, for: .normal)
                    self?.sizeToFit()
                }
            }

        [Const.systemTheme, Const.lightTheme, Const.darkTheme]
            .enumerated()
            .filter { index, value in
                index == UserDefaultsRepository.currentAppearance()
            }
            .forEach { index, value in
                setTitle(value, for: .normal)
            }

        menu = UIMenu(title: Const.themeMenuTitle,
                             options: .displayInline,
                             children: children)
        showsMenuAsPrimaryAction = true

        setTitleColor(.systemBlue, for: .normal)
        sizeToFit()
    }
}
