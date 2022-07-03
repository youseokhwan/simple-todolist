//
//  FormViewController.swift
//  Todolist
//
//  Created by 유석환 on 2022/06/24.
//

import UIKit

import SnapKit

final class FormViewController: UIViewController {
    private let viewModel = FormViewModel()

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

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    private func configure() {
        configureViews()
        configureConstraints()
    }

    private func configureViews() {
        view.backgroundColor = .systemBackground

        [contextTextField, publishedDateLabel, publishedDateButton, endDateLabel, endDateButton]
            .forEach {
                $0.backgroundColor = .systemGray // 임시
                view.addSubview($0)
            }
    }

    private func configureConstraints() {
        contextTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }

        publishedDateLabel.snp.makeConstraints { make in
            make.top.equalTo(contextTextField.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.width.equalTo(60)
            make.height.equalTo(30)
        }

        publishedDateButton.snp.makeConstraints { make in
            make.centerY.equalTo(publishedDateLabel)
            make.leading.equalTo(publishedDateLabel.snp.trailing).offset(20)
            make.width.equalTo(180)
            make.height.equalTo(30)
        }

        endDateLabel.snp.makeConstraints { make in
            make.top.equalTo(publishedDateLabel.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.width.equalTo(60)
            make.height.equalTo(30)
        }

        endDateButton.snp.makeConstraints { make in
            make.centerY.equalTo(endDateLabel)
            make.leading.equalTo(endDateLabel.snp.trailing).offset(20)
            make.width.equalTo(180)
            make.height.equalTo(30)
        }
    }
}
