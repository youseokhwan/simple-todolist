//
//  ThemeTableViewCell.swift
//  Todolist
//
//  Created by Jae Kyeong Ko on 2022/07/20.
//

import UIKit

import SnapKit

final class ThemeTableViewCell: UITableViewCell {
    private lazy var titleLabel = UILabel()
    private lazy var currentThemeLabel = UILabel()
    private lazy var button: UIButton = {
        let button = UIButton()
        let systemMode = UIAction(title: Const.systemTheme) { action in
            print("system")
        }
        let lightMode = UIAction(title: Const.lightTheme) { action in
            print("light")
        }
        let darkMode = UIAction(title: Const.darkTheme) { action in
            print("dark")
        }

        button.menu = UIMenu(title: Const.themeMenuTitle,
                             options: .displayInline,
                             children: [systemMode, lightMode, darkMode])
        button.showsMenuAsPrimaryAction = true

        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    func update(title: String, currentTheme: String) {
        titleLabel.text = title
        currentThemeLabel.text = currentTheme
    }
}

private extension ThemeTableViewCell {
    func configure() {
        configureViews()
        configureConstraints()
    }

    func configureViews() {
        [titleLabel, currentThemeLabel, button].forEach {
            contentView.addSubview($0)
        }
    }

    func configureConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(13)
        }

        currentThemeLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-13)
        }
    }
}
