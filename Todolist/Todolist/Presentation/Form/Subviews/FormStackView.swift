//
//  FormStackView.swift
//  Todolist
//
//  Created by 유석환 on 2022/07/04.
//

import UIKit

final class FormStackView: UIStackView {
    private lazy var contextTextField: UITextField = {
        let textField = UITextField()
        return textField
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    private func configure() {
        configureViews()
    }

    private func configureViews() {
        axis = .vertical

        [contextTextField]
            .forEach {
                $0.backgroundColor = .systemGray // TODO: UI 작업 후 삭제
                addArrangedSubview($0)
            }
    }
}
