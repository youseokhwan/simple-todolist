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
    private lazy var publishedDateView: FormDateView = {
        let formDateView = FormDateView()
        formDateView.updateText(label: "시작일", button: "2022.07.04(월)")
        return formDateView
    }()
    private lazy var endDateView: FormDateView = {
        let formDateView = FormDateView()
        formDateView.updateText(label: "마감일", button: "2022.07.11(월)")
        return formDateView
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
        configureViews()
    }

    private func configureViews() {
        axis = .vertical

        [contextTextField, publishedDateView, endDateView]
            .forEach {
                $0.backgroundColor = .systemGray // TODO: UI 작업 후 삭제
                addArrangedSubview($0)
            }
    }
}
