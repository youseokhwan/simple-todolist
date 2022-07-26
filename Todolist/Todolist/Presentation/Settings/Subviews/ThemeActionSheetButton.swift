//
//  ThemeActionSheetButton.swift
//  Todolist
//
//  Created by Jae Kyeong Ko on 2022/07/26.
//

import UIKit

class ThemeActionSheetButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

private extension ThemeActionSheetButton {
    func configure() {
        configureViews()
    }

    func configureViews() {

    }
}
