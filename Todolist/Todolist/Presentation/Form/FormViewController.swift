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

    private lazy var titleLabel: UILabel = {
        let label = UILabel()

        label.text = LabelText.formTitleAtCreation.rawValue
        label.textColor = UIColor(named: ColorSet.text100.rawValue)
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center

        return label
    }()
    private lazy var stackView = FormStackView()
    private lazy var saveButton: RoundedButton = {
        let button = RoundedButton()

        button.setTitle(type: .form)

        return button
    }()

    convenience init(task: Task) {
        self.init(nibName: nil, bundle: nil)

        titleLabel.text = LabelText.formTitleAtModification.rawValue

        viewModel.id.accept(task.id)
        viewModel.title.accept(task.title)
        viewModel.isDone.accept(task.isDone)
        viewModel.isDaily.accept(task.isDaily)
        viewModel.createdDate.accept(task.createdDate)

        stackView.titleRx.text.onNext(task.title)
        stackView.doneRx.isOn.onNext(task.isDone)
        stackView.dailyRx.isOn.onNext(task.isDaily)
        stackView.dateRx.date.onNext(task.createdDate)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if viewModel.id.value == FormViewModel.tempIDForNewTask {
            stackView.showKeyboard()
        }
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
        let recognizer = UITapGestureRecognizer(target: self,
                                                action: #selector(tappedOutsideOfKeyboard(_:)))

        view.backgroundColor = UIColor(named: ColorSet.background100.rawValue)
        view.addGestureRecognizer(recognizer)

        [titleLabel, stackView, saveButton].forEach {
            view.addSubview($0)
        }
    }

    func configureBind() {
        stackView.titleRx.text
            .orEmpty
            .observe(on: MainScheduler.asyncInstance)
            .map { String($0.prefix(FormStackView.titleTextViewMaxCount)) }
            .subscribe(onNext: { [weak self] text in
                self?.stackView.titleRx.text.onNext(text)
                self?.stackView.updateCount()
                self?.viewModel.title.accept(text)
            })
            .disposed(by: disposeBag)

        stackView.doneRx.isOn
            .bind(to: viewModel.isDone)
            .disposed(by: disposeBag)

        stackView.dailyRx.isOn
            .bind(to: viewModel.isDaily)
            .disposed(by: disposeBag)

        stackView.dateRx.date
            .bind(to: viewModel.createdDate)
            .disposed(by: disposeBag)

        saveButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.viewModel.saveTask()
                self?.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
    }

    func configureConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
        }

        stackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }

        saveButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.leading.trailing.equalToSuperview().inset(22)
            make.height.equalTo(44)
        }
    }
}
