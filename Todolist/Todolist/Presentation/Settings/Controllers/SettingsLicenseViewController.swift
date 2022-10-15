//
//  SettingsLicenseViewController.swift
//  Todolist
//
//  Created by Jae Kyeong Ko on 2022/08/13.
//

import UIKit

import SnapKit

final class SettingsLicenseViewController: UIViewController {
    private let viewModel = SettingsLicenseViewModel()

    private lazy var textView: UITextView = {
        let textView = UITextView()

        textView.isEditable = false

        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

private extension SettingsLicenseViewController {
    func configure() {
        configureViews()
        configureConstraints()
    }

    func configureViews() {
        view.backgroundColor = .systemBackground

        navigationItem.largeTitleDisplayMode = .never

        textView.text = viewModel.openSourceLicenseText()
        textView.contentOffset = CGPoint(x: 0, y: 0)
        view.addSubview(textView)
    }

    func configureConstraints() {
        textView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
