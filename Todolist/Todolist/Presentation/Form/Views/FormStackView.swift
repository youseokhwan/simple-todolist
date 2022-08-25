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
    private lazy var titleTextView = PlaceholderTextView(
        font: .systemFont(ofSize: 16),
        placeholder: Const.titleTextViewPlaceholder
    )
    private lazy var textCountLabel: UILabel = {
        let label = UILabel()

        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .right

        return label
    }()
    private lazy var dailyView = FormDailyView()

    var textViewRx: Reactive<PlaceholderTextView> {
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

        textCountLabel.text = "\(text.count)/\(Const.titleTextViewMaxCount)"
    }
}

private extension FormStackView {
    func configure() {
        configureViews()
    }

    func configureViews() {
        axis = .vertical

        [titleTextView, textCountLabel, dailyView].forEach {
            addArrangedSubview($0)
        }
    }
}
