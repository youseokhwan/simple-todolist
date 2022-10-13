//
//  ThemeTableViewCell.swift
//  Todolist
//
//  Created by Jae Kyeong Ko on 2022/07/20.
//

import UIKit

import SnapKit

final class SettingsTableViewCell: UITableViewCell {
    static let identifier = "SettingsTableViewCell"

    private lazy var titleLabel: UILabel = {
        let label = UILabel()

        label.font = UIFont(.theCircleM, size: 18)

        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    func update(title: String) {
        titleLabel.text = title
    }
}

private extension SettingsTableViewCell {
    func configure() {
        configureViews()
        configureConstraints()
    }

    func configureViews() {
        selectionStyle = .none
        accessoryType = .disclosureIndicator
        contentView.addSubview(titleLabel)
    }

    func configureConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(13)
        }
    }
}
