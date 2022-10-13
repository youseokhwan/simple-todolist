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
        label.font = UIFont(.theCircleB, size: 26)
        label.textColor = UIColor(.commonText100)

        return label
    }()
    private lazy var settingsButton: UIButton = {
        let button = UIButton()
        let image = UIImage(.settings)

        button.setImage(image, for: .normal)

        return button
    }()
    private lazy var tableView: UITableView = {
        let tableView = UITableView()

        tableView.backgroundColor = UIColor(.commonBackground100)
        tableView.register(TasksTableViewCell.self,
                           forCellReuseIdentifier: TasksTableViewCell.identifier)
        tableView.rowHeight = 80
        tableView.separatorStyle = .none
        tableView.dragInteractionEnabled = true
        tableView.dragDelegate = self
        tableView.dropDelegate = self

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
        view.backgroundColor = UIColor(.commonBackground100)

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

        tableView.rx.itemMoved
            .subscribe(onNext: { [weak self] sourceIndexPath, destinationIndexPath in
                self?.viewModel.moveTask(at: sourceIndexPath.row, to: destinationIndexPath.row)
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

        delete.backgroundColor = UIColor(.commonBackground100)
        delete.image = UIImage(.delete)?.swipeImage
        configuration.performsFirstActionWithFullSwipe = false

        return configuration
    }
}

extension TasksViewController: UITableViewDragDelegate, UITableViewDropDelegate {
    func tableView(_ tableView: UITableView,
                   itemsForBeginning session: UIDragSession,
                   at indexPath: IndexPath) -> [UIDragItem] {
        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()

        return [UIDragItem(itemProvider: NSItemProvider())]
    }

    func tableView(
        _ tableView: UITableView,
        dropSessionDidUpdate session: UIDropSession,
        withDestinationIndexPath destinationIndexPath: IndexPath?
    ) -> UITableViewDropProposal {
        let operation: UIDropOperation = session.localDragSession != nil ? .move : .cancel
        let intent: UITableViewDropProposal.Intent = session.localDragSession != nil ?
            .insertAtDestinationIndexPath : .unspecified

        return UITableViewDropProposal(operation: operation, intent: intent)
    }

    func tableView(_ tableView: UITableView,
                   performDropWith coordinator: UITableViewDropCoordinator) { }
}
