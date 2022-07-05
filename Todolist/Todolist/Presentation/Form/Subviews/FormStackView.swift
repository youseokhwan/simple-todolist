//
//  FormStackView.swift
//  Todolist
//
//  Created by 유석환 on 2022/07/04.
//

import UIKit

final class FormStackView: UIStackView {
    var delegate: UITextFieldDelegate? {
        didSet {
            contextTextField.delegate = delegate
        }
    }

    private lazy var contextTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.font = .systemFont(ofSize: 24)
        textField.attributedPlaceholder = NSAttributedString(
            string: "할 일을 입력하세요",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray]
        )
        return textField
    }()
    private lazy var dailyView = FormDailyView()

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
        spacing = 20

        [contextTextField, dailyView].forEach {
            addArrangedSubview($0)
        }
    }
}