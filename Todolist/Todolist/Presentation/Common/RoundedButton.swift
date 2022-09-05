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

        var image: String {
            switch self {
            case .tasks:
                return Const.formButtonImage
            case .form:
                return Const.saveButtonImage
            }
        }
        var title: String {
            switch self {
            case .tasks:
                return Const.formButtonTitle
            case .form:
                return Const.saveButtonTitle
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

    func setImage(type: ButtonType) {
        let image = UIImage(named: type.image)?.resizedImage(size: CGSize(width: 30, height: 30))

        setImage(image, for: .normal)
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
        contentHorizontalAlignment = .leading
        backgroundColor = UIColor(red: 1, green: 241/255, blue: 227/255, alpha: 1)
        setTitleColor(UIColor.black, for: .normal)
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
    }
}
