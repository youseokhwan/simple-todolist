//
//  TasksViewController.swift
//  Todolist
//
//  Created by 유석환 on 2022/06/24.
//

import AVFoundation
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
        tableView.separatorStyle = .none

        return tableView
    }()
    private lazy var formButton: TasksRoundedButton = {
        let button = TasksRoundedButton()
        let image = UIImage(named: Const.formButtonImage)

        button.setImage(image, for: .normal)
        button.imageSize = CGSize(width: 30, height: 30)
        button.backgroundColor = UIColor(red: 1, green: 241/255, blue: 227/255, alpha: 1)
        button.setTitle(Const.formButtonTitle, for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18)

        return button
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
            )) { [weak self] index, task, cell in
                cell.updateUI(by: task)
                cell.doneButtonTapHandler = {
                    self?.viewModel.updateIsDone(of: task, value: !task.isDone)
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                }
            }
            .disposed(by: disposeBag)

        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let task = self?.viewModel.allTasks.value[indexPath.row] else { return }

                let controller = FormViewController(task: task)

                self?.present(controller, animated: true)
            })
            .disposed(by: disposeBag)

        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)

        formButton.rx.tap
            .subscribe(onNext: { [weak self] in
                let formViewController = FormViewController()

                self?.present(formViewController, animated: true)
            })
            .disposed(by: disposeBag)
    }

    func configureConstraints() {
        todayLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            make.leading.equalToSuperview().offset(26)
        }

        settingsButton.snp.makeConstraints { make in
            make.centerY.equalTo(todayLabel)
            make.trailing.equalToSuperview().offset(-22)
            make.width.height.equalTo(44)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(settingsButton.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(22)
        }

        formButton.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom)
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
        let configuration = UISwipeActionsConfiguration(actions: [delete])

        delete.backgroundColor = .white
        delete.image = UIImage(named: Const.deleteButtonImage)?.swipeImage
        configuration.performsFirstActionWithFullSwipe = false

        return configuration
    }
}
