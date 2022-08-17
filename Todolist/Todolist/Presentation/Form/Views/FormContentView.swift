//
//  FormContentView.swift
//  Todolist
//
//  Created by Jae Kyeong Ko on 2022/08/17.
//

import UIKit

import RxCocoa
import RxSwift

final class FormContentView: UIView {
    private lazy var contextTextField: UITextField = {
        let textField = UITextField()

        textField.borderStyle = .roundedRect
        textField.font = .systemFont(ofSize: 24)
        textField.placeholder = Const.contextTextFieldPlaceholder

        return textField
    }()

    var textFieldRx: Reactive<UITextField> {
        return contextTextField.rx
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func showKeyboard() {
        contextTextField.becomeFirstResponder()
    }

    func updateToValidRangeText() {
        guard let text = contextTextField.text,
              text.count > Const.contextTextFieldMaxCount else { return }

        let lastIndex = text.index(text.startIndex, offsetBy: Const.contextTextFieldMaxCount)
        let validRangeText = String(text[...lastIndex])

        contextTextField.text = validRangeText
    }
}
