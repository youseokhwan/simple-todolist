//
//  FormViewController.swift
//  Todolist
//
//  Created by 유석환 on 2022/06/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

final class FormViewController: UIViewController {
    private let viewModel = FormViewModel()
    private let disposeBag = DisposeBag()

    private lazy var addButton: UIButton = {
        let button = UIButton()
        let buttonImageConfiguration = UIImage.SymbolConfiguration(pointSize: 25)
        let image = UIImage(systemName: "checkmark")
        button.setImage(image, for: .normal)
        return button
    }()
    private lazy var scrollView = UIScrollView()
    private lazy var stackView = FormStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    private func configure() {
        configureViews()
        configureDelegates()
        configureConstraints()
        configureRx()
    }

    private func configureViews() {
        view.backgroundColor = .systemBackground

        let addBarButton = UIBarButtonItem(customView: addButton)
        navigationItem.rightBarButtonItem = addBarButton

        let recognizer = UITapGestureRecognizer(target: self,
                                                action: #selector(tappedOutsideOfKeyboard(_:)))
        scrollView.addGestureRecognizer(recognizer)

        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
    }

    private func configureDelegates() {
        stackView.delegate = self
    }

    private func configureConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(20)
        }

        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.bottom.centerX.width.equalToSuperview()
        }
    }

    private func configureRx() {
        addButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.viewModel.addTask()
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)

        stackView.textFieldRx.text
            .subscribe(onNext: { [weak self] text in
                self?.viewModel.context = text ?? ""
            })
            .disposed(by: disposeBag)
    }

    @objc
    private func tappedOutsideOfKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(false)
    }
}

extension FormViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text,
              text.count > 20 else { return }

        let startIndex = text.startIndex
        let endIndex = text.index(startIndex, offsetBy: 20)

        textField.text = String(text[startIndex..<endIndex])
    }
}
