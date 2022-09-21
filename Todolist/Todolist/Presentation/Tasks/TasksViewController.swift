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

        label.text = Date.monthDayWeekday
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = UIColor(named: ColorSet.text100.rawValue)

        return label
    }()
    private lazy var settingsButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: ButtonImage.settings.rawValue)

        button.setImage(image, for: .normal)

        return button
    }()
    private lazy var tableView: UITableView = {
        let tableView = UITableView()

        tableView.backgroundColor = UIColor(named: ColorSet.background100.rawValue)
        tableView.register(TasksTableViewCell.self,
                           forCellReuseIdentifier: TasksTableViewCell.identifier)
        tableView.rowHeight = 80
        tableView.separatorStyle = .none

        return tableView
    }()
    private lazy var addButton: RoundedButton = {
        let button = RoundedButton()

        button.setTitle(type: .tasks)

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

private extension TasksViewController {
    func configure() {
        configureViews()
        configureBind()
        configureConstraints()
    }

    func configureViews() {
        view.backgroundColor = UIColor(named: ColorSet.background100.rawValue)

        [todayLabel, addButton, settingsButton, tableView].forEach {
            view.addSubview($0)
        }
    }

    func configureBind() {
        NotificationCenter.default.addObserver(
            viewModel,
            selector: #selector(viewModel.updateTasksAsOfToday),
            name: SceneDelegate.sceneWillEnterForeground,
            object: nil
        )

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

        addButton.rx.tap
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

        addButton.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom).offset(20)
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

        delete.backgroundColor = UIColor(named: ColorSet.background100.rawValue)
        delete.image = UIImage(named: ButtonImage.delete.rawValue)?.swipeImage
        configuration.performsFirstActionWithFullSwipe = false

        return configuration
    }
}
