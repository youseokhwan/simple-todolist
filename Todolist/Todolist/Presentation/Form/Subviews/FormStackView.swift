//
//  FormStackView.swift
//  Todolist
//
//  Created by 유석환 on 2022/07/04.
//

import UIKit

import RxCocoa
import RxSwift

final class FormStackView: UIStackView {
    static let contextMaxCount = 20

    private lazy var contextTextField: UITextField = {
        let textField = UITextField()

        textField.borderStyle = .roundedRect
        textField.font = .systemFont(ofSize: 24)
        textField.placeholder = "할 일을 입력하세요"

        return textField
    }()
    private lazy var dailyView = FormDailyView()

    var textFieldRx: Reactive<UITextField> {
        return contextTextField.rx
    }
    var switchRx: Reactive<UISwitch> {
        return dailyView.switchRx
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)

        configure()
    }

    func updateToValidRangeText() {
        guard let text = contextTextField.text,
              text.count > Self.contextMaxCount else { return }

        let lastIndex = text.index(text.startIndex, offsetBy: Self.contextMaxCount)
        let validRangeText = String(text[...lastIndex])

        contextTextField.text = validRangeText
    }
}

private extension FormStackView {
    func configure() {
        configureViews()
    }

    func configureViews() {
        axis = .vertical
        spacing = 20

        [contextTextField, dailyView].forEach {
            addArrangedSubview($0)
        }
    }
}
