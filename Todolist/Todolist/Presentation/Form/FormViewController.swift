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

        label.text = Const.formTitleCreateLabelText
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center

        return label
    }()
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        let recognizer = UITapGestureRecognizer(target: self,
                                                action: #selector(tappedOutsideOfKeyboard(_:)))

        scrollView.addGestureRecognizer(recognizer)

        return scrollView
    }()
    private lazy var containerView = UIView()
    private lazy var stackView = FormStackView()
    private lazy var saveButton: RoundedButton = {
        let button = RoundedButton()

        button.setImage(type: .form)
        button.setTitle(type: .form)

        return button
    }()

    convenience init(task: Task) {
        self.init(nibName: nil, bundle: nil)

        titleLabel.text = Const.formTitleDetailLabelText

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

        if viewModel.id.value == Const.tempIDForNewTask {
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
        view.backgroundColor = .systemBackground

        scrollView.addSubview(containerView)
        containerView.addSubview(stackView)
        [titleLabel, scrollView, saveButton].forEach {
            view.addSubview($0)
        }
    }

    func configureBind() {
        stackView.titleRx.text
            .orEmpty
            .observe(on: MainScheduler.asyncInstance)
            .scan("") { old, new -> String in
                return new.count > Const.titleTextViewMaxCount ? old : new
            }
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
            make.top.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }

        scrollView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel).offset(20)
            make.bottom.leading.trailing.equalToSuperview()
        }

        containerView.snp.makeConstraints { make in
            make.edges.width.equalToSuperview()
            make.height.equalToSuperview().priority(250)
        }

        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }

        saveButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.leading.trailing.equalToSuperview().inset(22)
            make.height.equalTo(44)
        }
    }
}
