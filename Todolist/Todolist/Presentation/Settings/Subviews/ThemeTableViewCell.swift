//
//  ThemeTableViewCell.swift
//  Todolist
//
//  Created by Jae Kyeong Ko on 2022/07/20.
//

import UIKit

final class ThemeTableViewCell: UITableViewCell {
    private let identifier = "ThemeTableViewCell"

    private lazy var titleLabel = UILabel()
    private lazy var currentThemeLabel = UILabel()
    private lazy var button: UIButton = {
        let button = UIButton()
        let systemMode = UIAction(title: "시스템") { action in
            print("system")
        }
        let lightMode = UIAction(title: "라이트") { action in
            print("light")
        }
        let darkMode = UIAction(title: "다크") { action in
            print("dark")
        }
        let cancel = UIAction(title: "취소",attributes: .destructive) { _ in
            print("cancel")
        }

        button.menu = UIMenu(
            title: "", options: .displayInline, children: [systemMode, lightMode, darkMode, cancel]
        )
        button.showsMenuAsPrimaryAction = true

        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
