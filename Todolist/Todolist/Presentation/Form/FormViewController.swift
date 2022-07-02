//
//  FormViewController.swift
//  Todolist
//
//  Created by 유석환 on 2022/06/24.
//

import UIKit

final class FormViewController: UIViewController {
    private let viewModel = FormViewModel()

    private lazy var contextTextField: UITextField = {
        let textField = UITextField()
        return textField
    }()
    private lazy var publishedDateLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    private lazy var publishedDateButton: UIButton = {
        let button = UIButton()
        return button
    }()
    private lazy var endDateLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    private lazy var endDateButton: UIButton = {
        let button = UIButton()
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
