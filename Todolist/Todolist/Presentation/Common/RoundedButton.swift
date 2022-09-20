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

    func setTitle(type: ButtonType) {
        setTitle(type.title, for: .normal)
    }
}

private extension RoundedButton {
    func configure() {
        configureViews()
    }

    func configureViews() {
        layer.cornerRadius = 10
        contentHorizontalAlignment = .center
        backgroundColor = UIColor(red: 1, green: 241/255, blue: 227/255, alpha: 1)
        setTitleColor(UIColor.black, for: .normal)
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
    }
}
