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
    private lazy var button = UIButton()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
