//
//  FormStackView.swift
//  Todolist
//
//  Created by 유석환 on 2022/07/04.
//

import UIKit

final class FormStackView: UIStackView {
    private lazy var contextTextField: UITextField = {
        let textField = UITextField()
        return textField
    }()
    private lazy var publishedDateLabel: UILabel = {
        let label = UILabel()
        label.text = "시작일"
        return label
    }()
    private lazy var publishedDateButton: UIButton = {
        let button = UIButton()
        button.setTitle("2022.07.03(일)", for: .normal)
        return button
    }()
    private lazy var endDateLabel: UILabel = {
        let label = UILabel()
        label.text = "종료일"
        return label
    }()
    private lazy var endDateButton: UIButton = {
        let button = UIButton()
        button.setTitle("2022.07.10(일)", for: .normal)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    private func configure() {
        axis = .vertical

        [contextTextField, publishedDateLabel, publishedDateButton, endDateLabel, endDateButton]
            .forEach {
                $0.backgroundColor = .systemGray // TODO: UI 작업 후 삭제
                addArrangedSubview($0)
            }
    }
}
