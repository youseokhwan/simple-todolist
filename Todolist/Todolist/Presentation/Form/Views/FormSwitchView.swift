//
//  FormSwitchView.swift
//  Todolist
//
//  Created by 유석환 on 2022/07/04.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

final class FormSwitchView: UIView {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()

        label.textColor = UIColor(named: ColorSet.text_100.rawValue)

        return label
    }()
    private lazy var toggleSwitch: UISwitch = {
        let `switch` = UISwitch()
        
        `switch`.onTintColor = .systemTeal
        
        return `switch`
    }()

    var title = "" {
        didSet {
            titleLabel.text = title
        }
    }
    var switchRx: Reactive<UISwitch> {
        return toggleSwitch.rx
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
}

private extension FormSwitchView {
    func configure() {
        configureViews()
        configureConstraints()
    }

    func configureViews() {
        [titleLabel, toggleSwitch].forEach {
            addSubview($0)
        }
    }

    func configureConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerY.leading.height.equalToSuperview()
            make.width.equalTo(70)
        }

        toggleSwitch.snp.makeConstraints { make in
            make.centerY.height.equalToSuperview()
            make.leading.equalTo(titleLabel.snp.trailing).offset(20)
        }
    }
}
