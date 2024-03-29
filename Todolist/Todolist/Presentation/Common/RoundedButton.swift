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
                return String(.addButton)
            case .form:
                return String(.saveButton)
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

        guard let left = UIColor(.buttonBackgroundLeft),
              let right = UIColor(.buttonBackgroundRight) else { return }

        addGradientLayer(colors: [left.cgColor, right.cgColor])
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
        setTitleColor(UIColor(.buttonText), for: .normal)
        titleLabel?.font = .instance(.theCircleM, size: 18)
    }
}
