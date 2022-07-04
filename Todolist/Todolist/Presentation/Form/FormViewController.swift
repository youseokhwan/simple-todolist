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

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()

    // TODO: StackView 분리해야 함
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

        view.addSubview(scrollView)
        scrollView.addSubview(stackView)

        [contextTextField, publishedDateLabel, publishedDateButton, endDateLabel, endDateButton]
            .forEach {
                $0.backgroundColor = .systemGray // TODO: UI 작업 후 삭제
                stackView.addArrangedSubview($0)
            }
    }

    private func configureConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        stackView.snp.makeConstraints { make in
            make.top.bottom.centerX.width.equalToSuperview()
        }
    }
}
