//
//  OpenSourceLicenseViewController.swift
//  Todolist
//
//  Created by Jae Kyeong Ko on 2022/08/13.
//

import UIKit

class OpenSourceLicenseViewController: UIViewController {
    private lazy var textView: UITextView = {
        let textView = UITextView()

        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

private extension OpenSourceLicenseViewController {
    func configure() {
        configureViews()
    }

    func configureViews() {
        view.backgroundColor = .systemBackground
        view.addSubview(textView)
    }
}
