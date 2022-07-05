//
//  FormDailyView.swift
//  Todolist
//
//  Created by 유석환 on 2022/07/04.
//

import UIKit

import SnapKit

final class FormDailyView: UIView {
    private lazy var dailyLabel: UILabel = {
        let label = UILabel()
        label.text = "매일 반복"
        return label
    }()
    private lazy var dailySwitch: UISwitch = {
        let dailySwitch = UISwitch()
        return dailySwitch
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    private func configure() {
        configureViews()
        configureConstraints()
    }

    private func configureViews() {
        [dailyLabel, dailySwitch].forEach {
            addSubview($0)
        }
    }

    private func configureConstraints() {
        dailyLabel.snp.makeConstraints { make in
            make.leading.height.equalToSuperview()
            make.width.equalTo(70)
        }

        dailySwitch.snp.makeConstraints { make in
            make.leading.equalTo(dailyLabel.snp.trailing).offset(20)
            make.height.equalToSuperview()
        }
    }
}
