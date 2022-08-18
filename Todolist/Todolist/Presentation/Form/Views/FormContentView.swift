//
//  FormContentView.swift
//  Todolist
//
//  Created by Jae Kyeong Ko on 2022/08/17.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

final class FormContentView: UIView {
    private lazy var contentTextField: UITextField = {
        let textField = UITextField()

        textField.borderStyle = .roundedRect
        textField.font = .systemFont(ofSize: 24)
        textField.placeholder = Const.contextTextFieldPlaceholder

        return textField
    }()
    private lazy var textCountLabel: UILabel = {
        let label = UILabel()

        label.font = .systemFont(ofSize: 14)

        return label
    }()

    var textFieldRx: Reactive<UITextField> {
        return contentTextField.rx
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    func showKeyboard() {
        contentTextField.becomeFirstResponder()
    }

    func updateCount(content: String) {
        textCountLabel.text = "\(content.count)/\(Const.contextTextFieldMaxCount)"
    }

    func updateToValidRangeText() {
        guard let text = contentTextField.text,
              text.count > Const.contextTextFieldMaxCount else { return }

        let lastIndex = text.index(text.startIndex, offsetBy: Const.contextTextFieldMaxCount)
        let validRangeText = String(text[...lastIndex])

        contentTextField.text = validRangeText
    }
}

private extension FormContentView {
    func configure() {
        configureViews()
        configureConstraints()
    }

    func configureViews() {
        [contentTextField, textCountLabel].forEach {
            addSubview($0)
        }
    }

    func configureConstraints() {
        contentTextField.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }

        textCountLabel.snp.makeConstraints { make in
            make.top.equalTo(contentTextField.snp.bottom)
            make.trailing.equalToSuperview()
        }
    }
}
