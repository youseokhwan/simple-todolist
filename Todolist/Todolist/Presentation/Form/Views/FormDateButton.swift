//
//  FormDateButton.swift
//  Todolist
//
//  Created by 유석환 on 2022/08/29.
//

import UIKit

final class FormDateButton: UIButton {
    enum DateType {
        case year
        case month
        case day
        case dayOfTheWeek
        case none
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
    }

    func configureViews() {
        layer.cornerRadius = 10
        backgroundColor = .lightGray
        setTitleColor(UIColor.black, for: .normal)
        setTitleColor(UIColor.red, for: .selected)
    }
}
