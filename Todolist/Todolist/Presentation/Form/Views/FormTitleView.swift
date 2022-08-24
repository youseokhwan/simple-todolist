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
    private lazy var titleTextView = PlaceholderTextView(
        font: .systemFont(ofSize: 16),
        placeholder: Const.titleTextViewPlaceholder
    )
    private lazy var textCountLabel: UILabel = {
        let label = UILabel()

        label.font = .systemFont(ofSize: 14)

        return label
    }()

    var textViewRx: Reactive<PlaceholderTextView> {
        return titleTextView.rx
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
        titleTextView.becomeFirstResponder()
    }

    func updateCount() {
        guard let text = titleTextView.text else { return }

        textCountLabel.text = "\(text.count)/\(Const.titleTextViewMaxCount)"
    }
}

private extension FormTitleView {
    func configure() {
        configureViews()
        configureConstraints()
    }

    func configureViews() {
        [titleTextView, textCountLabel].forEach {
            addSubview($0)
        }
    }

    func configureConstraints() {
        titleTextView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }

        textCountLabel.snp.makeConstraints { make in
            make.top.equalTo(titleTextView.snp.bottom)
            make.trailing.equalToSuperview()
        }
    }
}
