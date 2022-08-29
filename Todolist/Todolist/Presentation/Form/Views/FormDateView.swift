//
//  FormDateView.swift
//  Todolist
//
//  Created by 유석환 on 2022/08/29.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

final class FormDateView: UIView {
    private lazy var titleLabel = UILabel()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()

        stackView.axis = .horizontal
        stackView.spacing = 5

        return stackView
    }()
    private lazy var yearButton = FormDateButton()
    private lazy var monthButton = FormDateButton()
    private lazy var dayButton = FormDateButton()

    var title = "" {
        didSet {
            titleLabel.text = title
        }
    }
    var yearRx: Reactive<FormDateButton> {
        return yearButton.rx
    }
    var monthRx: Reactive<FormDateButton> {
        return monthButton.rx
    }
    var dayRx: Reactive<FormDateButton> {
        return dayButton.rx
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
}

private extension FormDateView {
    func configure() {
        configureViews()
        configureConstraints()
    }

    func configureViews() {
        [yearButton, monthButton, dayButton].forEach {
            stackView.addArrangedSubview($0)
        }

        [titleLabel, stackView].forEach {
            addSubview($0)
        }
    }

    func configureConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerY.leading.height.equalToSuperview()
            make.width.equalTo(70)
        }

        stackView.snp.makeConstraints { make in
            make.centerY.height.equalToSuperview()
            make.leading.equalTo(titleLabel.snp.trailing).offset(20)
        }
    }
}
