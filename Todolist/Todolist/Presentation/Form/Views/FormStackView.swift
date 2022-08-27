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
    private lazy var dailyView = FormSwitchView()

    var textViewRx: Reactive<FormTextView> {
        return titleTextView.rx
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

        dailyView.title = Const.dailyLabelText

        [titleTextView, titleCountLabel, dailyView].forEach {
            addArrangedSubview($0)
        }
    }
}
