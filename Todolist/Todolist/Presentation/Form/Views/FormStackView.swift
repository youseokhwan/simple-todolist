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
    static let titleTextViewMaxCount = 100

    private lazy var titleTextView: FormTextView = {
        let textView = FormTextView()

        textView.textColor = UIColor(named: ColorSet.text100.rawValue)
        textView.placeholder = LabelText.formTextViewPlaceholder.rawValue
        textView.font = .systemFont(ofSize: 18)

        return textView
    }()
    private lazy var titleCountLabel: UILabel = {
        let label = UILabel()

        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor(named: ColorSet.background50.rawValue)
        label.textAlignment = .right

        return label
    }()
    private lazy var doneSwitchView: FormSwitchView = {
        let switchView = FormSwitchView()

        switchView.title = LabelText.isDone.rawValue

        return switchView
    }()
    private lazy var dailySwitchView: FormSwitchView = {
        let switchView = FormSwitchView()

        switchView.title = LabelText.isDaily.rawValue

        return switchView
    }()
    private lazy var createdDateView: FormDateView = {
        let dateView = FormDateView()

        dateView.title = LabelText.createdDate.rawValue

        return dateView
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
    var dateRx: Reactive<UIDatePicker> {
        return createdDateView.datePickerRx
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

        titleCountLabel.text = "\(text.count)/\(Self.titleTextViewMaxCount)"
        titleCountLabel.textColor = text.count == Self.titleTextViewMaxCount ? .red : .lightGray
    }
}

private extension FormStackView {
    func configure() {
        configureViews()
    }

    func configureViews() {
        axis = .vertical
        spacing = 20

        [titleTextView, titleCountLabel, doneSwitchView, dailySwitchView, createdDateView].forEach {
            addArrangedSubview($0)
        }

        setCustomSpacing(5, after: titleTextView)
    }
}
