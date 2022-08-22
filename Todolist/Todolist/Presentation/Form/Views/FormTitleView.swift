//
//  FormTitleView.swift
//  Todolist
//
//  Created by Jae Kyeong Ko on 2022/08/17.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

final class FormTitleView: UIView {
    private lazy var titleTextField: UITextField = {
        let textField = UITextField()

        textField.borderStyle = .roundedRect
        textField.font = .systemFont(ofSize: 24)
        textField.placeholder = Const.titleTextFieldPlaceholder

        return textField
    }()
    private lazy var textCountLabel: UILabel = {
        let label = UILabel()

        label.font = .systemFont(ofSize: 14)

        return label
    }()

    var textFieldRx: Reactive<UITextField> {
        return titleTextField.rx
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
        titleTextField.becomeFirstResponder()
    }

    func updateCount() {
        guard let text = titleTextField.text else { return }

        textCountLabel.text = "\(text.count)/\(Const.titleTextFieldMaxCount)"
    }
}

private extension FormTitleView {
    func configure() {
        configureViews()
        configureConstraints()
    }

    func configureViews() {
        [titleTextField, textCountLabel].forEach {
            addSubview($0)
        }
    }

    func configureConstraints() {
        titleTextField.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }

        textCountLabel.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom)
            make.trailing.equalToSuperview()
        }
    }
}
