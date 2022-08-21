//
//  TasksViewController.swift
//  Todolist
//
//  Created by 유석환 on 2022/06/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

final class TasksViewController: UIViewController {
    private let viewModel = TasksViewModel()
    private let disposeBag = DisposeBag()

    private lazy var todayLabel: UILabel = {
        let label = UILabel()

        label.text = Date.today
        label.font = .systemFont(ofSize: 22, weight: .bold)

        return label
    }()
    private lazy var settingsButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: Const.settingsButtonImage)

        button.setImage(image, for: .normal)

        return button
    }()
    private lazy var tableView: UITableView = {
        let tableView = UITableView()

        tableView.register(TasksTableViewCell.self,
                           forCellReuseIdentifier: TasksTableViewCell.identifier)
        tableView.rowHeight = 80

        return tableView
    }()
    private lazy var formButton: RoundedButton = {
        let image = UIImage(named: Const.formButtonImage)
        let title = "할 일 추가"

        return RoundedButton(title: title, image: image)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        viewModel.updateTasksAsOfToday()
    }
}

private extension TasksViewController {
    func configure() {
        configureViews()
        configureBind()
        configureConstraints()
    }

    func configureViews() {
        view.backgroundColor = .systemBackground

        [todayLabel, formButton, settingsButton, tableView].forEach {
            view.addSubview($0)
        }
    }

    func configureBind() {
        formButton.rx.tap
            .subscribe(onNext: { [weak self] in
                let formViewController = FormViewController()

                self?.present(formViewController, animated: true)
            })
            .disposed(by: disposeBag)

        settingsButton.rx.tap
            .subscribe(onNext: { [weak self] in
                let navigationController = SettingsNavigationController()

                self?.present(navigationController, animated: true)
            })
            .disposed(by: disposeBag)

        viewModel.allTasks
            .bind(to: tableView.rx.items(
                cellIdentifier: TasksTableViewCell.identifier,
                cellType: TasksTableViewCell.self
            )) { index, element, cell in
                cell.updateUI(by: element)
            }
            .disposed(by: disposeBag)

        tableView.rx.itemSelected
            .throttle(.milliseconds(500), scheduler: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] indexPath in
                guard let cell = self?.tableView.cellForRow(at: indexPath) as? TasksTableViewCell,
                      let task = self?.viewModel.allTasks.value[indexPath.row] else { return }

                self?.viewModel.updateIsChecked(of: task, value: !task.isChecked)
                cell.updateUI(by: task)
            })
            .disposed(by: disposeBag)

        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }

    func configureConstraints() {
        todayLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalToSuperview().offset(26)
        }

        settingsButton.snp.makeConstraints { make in
            make.centerY.equalTo(todayLabel)
            make.trailing.equalToSuperview().offset(-22)
            make.width.height.equalTo(44)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(todayLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(22)
        }

        formButton.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom).offset(10)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.leading.trailing.equalToSuperview().inset(22)
            make.height.equalTo(44)
        }
    }
}

extension TasksViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive,
                                        title: nil) { [weak self] action, view, completion in
            self?.viewModel.deleteTask(of: indexPath.row)
            completion(true)
        }
        let edit = UIContextualAction(style: .normal,
                                      title: nil) { [weak self] action, view, completion in
            if let task = self?.viewModel.allTasks.value[indexPath.row] {
                let controller = FormViewController(task: task)

                self?.present(controller, animated: true)
            }
            completion(true)
        }

        delete.image = UIImage(named: Const.deleteButtonImage)?.swipeImage
        edit.image = UIImage(named: Const.editButtonImage)?.swipeImage

        return UISwipeActionsConfiguration(actions: [delete, edit])
    }
}
