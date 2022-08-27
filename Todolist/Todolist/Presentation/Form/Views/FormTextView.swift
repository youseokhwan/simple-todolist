//
//  PlaceholderTextView.swift
//  Todolist
//
//  Created by Jae Kyeong Ko on 2022/08/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

final class FormTextView: UITextView {
    private let disposeBag = DisposeBag()

    private lazy var placeholderLabel: UILabel = {
        let label = UILabel()

        label.textColor = .lightGray
        label.sizeToFit()

        return label
    }()

    var placeholder = "" {
        didSet {
            placeholderLabel.text = placeholder
        }
    }

    override var font: UIFont? {
        didSet {
            placeholderLabel.font = font
        }
    }

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
}

private extension FormTextView {
    func configure() {
        configureViews()
        configureBind()
        configureConstraints()
    }

    func configureViews() {
        isScrollEnabled = false
        addSubview(placeholderLabel)
    }

    func configureBind() {
        rx.text
            .orEmpty
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] text in
                self?.placeholderLabel.isHidden = !text.isEmpty
            })
            .disposed(by: disposeBag)
    }

    func configureConstraints() {
        placeholderLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.leading.equalToSuperview().inset(5)
        }
    }
}