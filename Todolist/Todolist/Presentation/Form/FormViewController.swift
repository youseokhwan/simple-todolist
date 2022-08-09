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

    private lazy var saveButton: UIButton = {
        let button = UIButton()
        let buttonImageConfiguration = UIImage.SymbolConfiguration(pointSize: 25)
        let image = UIImage(systemName: Const.saveButtonImage,
                            withConfiguration: buttonImageConfiguration)

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

    convenience init(task: Task) {
        self.init(nibName: nil, bundle: nil)

        viewModel.taskID.accept(task.id)
        stackView.textFieldRx.text.onNext(task.context)
        stackView.switchRx.isOn.onNext(task.isDaily)
        viewModel.isChecked.accept(task.isChecked)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if viewModel.taskID.value == Const.tempIDForNewTask {
            stackView.showKeyboard()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sendNotificationCenter()
    }

    private func sendNotificationCenter() {
        NotificationCenter.default.post(
            name: NSNotification.Name(Const.notificationDismissFormViewController),
            object: nil
        )
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

        [scrollView, saveButton].forEach {
            view.addSubview($0)
        }
    }

    func configureBind() {
        saveButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.viewModel.saveTask()
                self?.dismiss(animated: true)
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

        saveButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(20)
        }

        stackView.snp.makeConstraints { make in
            make.centerX.bottom.width.equalToSuperview()
            make.top.equalTo(saveButton.snp.bottom).offset(20)
        }
    }
}
