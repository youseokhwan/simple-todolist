//
//  FormDateButton.swift
//  Todolist
//
//  Created by 유석환 on 2022/08/29.
//

import UIKit

final class FormDateButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
}

private extension FormDateButton {
    func configure() {
        configureViews()
    }

    func configureViews() {
        sizeToFit()
        layer.cornerRadius = 10
        backgroundColor = UIColor(red: 237.0/255.0, green: 234.0/255.0, blue: 237.0/255.0, alpha: 1)
        contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        setTitleColor(UIColor.black, for: .normal)
        setTitleColor(UIColor.red, for: .selected)
    }
}
