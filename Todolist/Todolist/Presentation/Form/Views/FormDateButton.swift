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
        
    }
}
