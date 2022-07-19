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
        let image = UIImage(systemName: "checkmark", withConfiguration: buttonImageConfiguration)

        button.setImage(image, for: .normal)

        return button
    }()
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        let recognizer = UITapGestureRecognizer(target: self,
                                                action: #selector(tappedOutsideOfKeyboard(_:)))

        scrollView.addGestureRecognizer(recognizer)
        scrollView.addSubview(stackView)

        return scrollView
    }()
    private lazy var stackView = FormStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    @objc
    private func tappedOutsideOfKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(false)
    }
}

private extension FormViewController {
    func configure() {
        configureViews()
        configureBind()
        configureConstraints()
    }

    func configureViews() {
        view.backgroundColor = .systemBackground

        let addBarButton = UIBarButtonItem(customView: addButton)

        navigationItem.rightBarButtonItem = addBarButton

        view.addSubview(scrollView)
    }

    func configureBind() {
        addButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.viewModel.addTask()
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)

        stackView.textFieldRx.text
            .orEmpty
            .subscribe(onNext: { [weak self] text in
                self?.stackView.updateToValidRangeText()
                self?.viewModel.context.accept(text)
            })
            .disposed(by: disposeBag)

        stackView.switchRx.isOn
            .bind(to: viewModel.isDaily)
            .disposed(by: disposeBag)
    }

    func configureConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(20)
        }

        stackView.snp.makeConstraints { make in
            make.centerX.bottom.width.equalToSuperview()
            make.top.equalToSuperview().offset(20)
        }
    }
}
