//
//  TasksRoundedButton.swift
//  Todolist
//
//  Created by Jae Kyeong Ko on 2022/08/29.
//

import UIKit

final class RoundedButton: UIButton {
    enum ButtonType {
        case tasks
        case form

        var title: String {
            switch self {
            case .tasks:
                return ButtonTitle.addButton.rawValue
            case .form:
                return ButtonTitle.saveButton.rawValue
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        addGradientLayer(colors: [UIColor.systemTeal.cgColor, UIColor.systemPurple.cgColor])
    }

    func setTitle(type: ButtonType) {
        setTitle(type.title, for: .normal)
    }
}

private extension RoundedButton {
    func configure() {
        configureViews()
    }

    func configureViews() {
        contentHorizontalAlignment = .center
        setTitleColor(UIColor(named: ColorSet.text.rawValue), for: .normal)
    }
}
