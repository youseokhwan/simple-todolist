//
//  MenuButton.swift
//  Todolist
//
//  Created by Jae Kyeong Ko on 2022/07/23.
//

import UIKit

final class ThemeButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

private extension ThemeButton {
    func configure() {
        configureViews()
    }

    func configureViews() {
    }
}
