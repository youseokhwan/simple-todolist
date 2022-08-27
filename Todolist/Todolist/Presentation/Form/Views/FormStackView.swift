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
    private lazy var titleTextView: FormTextView = {
        let textView = FormTextView()

        textView.placeholder = Const.titleTextViewPlaceholder
        textView.font = .systemFont(ofSize: 18)

        return textView
    }()
    private lazy var titleCountLabel: UILabel = {
        let label = UILabel()

        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .right

        return label
    }()
    private lazy var doneSwitchView: FormSwitchView = {
        let switchView = FormSwitchView()

        switchView.title = Const.doneLabelText

        return switchView
    }()
    private lazy var dailySwitchView: FormSwitchView = {
        let switchView = FormSwitchView()

        switchView.title = Const.dailyLabelText

        return switchView
    }()

    var titleRx: Reactive<FormTextView> {
        return titleTextView.rx
    }
    var doneRx: Reactive<UISwitch> {
        return doneSwitchView.switchRx
    }
    var dailyRx: Reactive<UISwitch> {
        return dailySwitchView.switchRx
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    func showKeyboard() {
        titleTextView.becomeFirstResponder()
    }

    func updateCount() {
        guard let text = titleTextView.text else { return }

        titleCountLabel.text = "\(text.count)/\(Const.titleTextViewMaxCount)"
    }
}

private extension FormStackView {
    func configure() {
        configureViews()
    }

    func configureViews() {
        axis = .vertical
        spacing = 20

        [titleTextView, titleCountLabel, doneSwitchView, dailySwitchView].forEach {
            addArrangedSubview($0)
        }
    }
}
