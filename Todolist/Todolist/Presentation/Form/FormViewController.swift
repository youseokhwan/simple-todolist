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

    private lazy var scrollView = UIScrollView()
    private lazy var stackView = FormStackView()

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
