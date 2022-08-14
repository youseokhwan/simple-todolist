//
//  OpenSourceLicenseViewController.swift
//  Todolist
//
//  Created by Jae Kyeong Ko on 2022/08/13.
//

import UIKit

import SnapKit

class OpenSourceLicenseViewController: UIViewController {
    private lazy var textView: UITextView = {
        let textView = UITextView()

        textView.text = License.allPakages
        textView.isEditable = false

        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

private extension OpenSourceLicenseViewController {
    func configure() {
        configureViews()
        configureConstraints()
    }

    func configureViews() {
        view.backgroundColor = .systemBackground
        view.addSubview(textView)
    }

    func configureConstraints() {
        textView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
