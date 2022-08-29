//
//  FormDateButton.swift
//  Todolist
//
//  Created by 유석환 on 2022/08/29.
//

import UIKit

import SnapKit

final class FormDateButton: UIButton {
    enum DateType {
        case year
        case month
        case day
        case dayOfTheWeek
        case none

        var width: Int {
            switch self {
            case .year:
                return 60
            case .month, .day:
                return 40
            case .dayOfTheWeek:
                return 70
            default:
                return 0
            }
        }
    }

    private var dateType: DateType = .none

    convenience init(type: DateType) {
        self.init()
        dateType = type
        configure()
    }
}

private extension FormDateButton {
    func configure() {
        configureViews()
        configureConstraints()
    }

    func configureViews() {
        layer.cornerRadius = 10
        backgroundColor = .lightGray
        setTitleColor(UIColor.black, for: .normal)
        setTitleColor(UIColor.red, for: .selected)
    }

    func configureConstraints() {
        snp.makeConstraints { make in
            make.width.equalTo(dateType.width)
        }
    }
}
