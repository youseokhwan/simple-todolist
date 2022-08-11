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
    private static let identifier = "TasksTableViewCell"

    private let viewModel = TasksViewModel()
    private let disposeBag = DisposeBag()

    private lazy var formButton: UIButton = {
        let button = UIButton()
        let buttonImageConfiguration = UIImage.SymbolConfiguration(pointSize: 25)

        button.setImage(UIImage(systemName: Const.formButtonImage,
                                withConfiguration: buttonImageConfiguration), for: .normal)

        return button
    }()
    private lazy var settingsButton: UIButton = {
        let button = UIButton()
        let buttonImageConfiguration = UIImage.SymbolConfiguration(pointSize: 25)

        button.setImage(UIImage(systemName: Const.settingsButtonImage,
                                withConfiguration: buttonImageConfiguration), for: .normal)

        return button
    }()
    private lazy var tableView: UITableView = {
        let tableView = UITableView()

        tableView.register(TasksTableViewCell.self,
                           forCellReuseIdentifier: Self.identifier)
        tableView.rowHeight = 80

        return tableView
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

        let formBarButton = UIBarButtonItem(customView: formButton)
        let settingsBarButton = UIBarButtonItem(customView: settingsButton)

        navigationItem.rightBarButtonItems = [formBarButton, settingsBarButton]
        navigationItem.title = Date.today
        navigationItem.backButtonTitle = Const.navigationBackButtonTitle

        view.addSubview(tableView)
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
                let settingsViewController = SettingsViewController()

                self?.navigationController?.pushViewController(settingsViewController, animated: true)
            })
            .disposed(by: disposeBag)

        viewModel.allTasks
            .bind(to: tableView.rx.items(
                cellIdentifier: Self.identifier,
                cellType: TasksTableViewCell.self
            )) { index, element, cell in
                cell.updateUI(by: element)
            }
            .disposed(by: disposeBag)

        tableView.rx.itemSelected
            .throttle(.seconds(1), scheduler: MainScheduler.asyncInstance)
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
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
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

        delete.image = UIImage(systemName: "trash.fill")
        edit.image = UIImage(systemName: "square.and.pencil")

        return UISwipeActionsConfiguration(actions: [delete, edit])
    }
}
