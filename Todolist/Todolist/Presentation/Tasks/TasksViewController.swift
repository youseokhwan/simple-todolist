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
    private static let formDismissed = NSNotification.Name("FormDismissed")
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
        fetchAllTasks()
    }

    @objc
    private func fetchAllTasks() {
        viewModel.fetchAllTasks()
    }
}

private extension TasksViewController {
    func configure() {
        configureViews()
        configureDelegates()
        configureBind()
        configureConstraints()
        configureObserver()
    }

    func configureViews() {
        view.backgroundColor = .systemBackground

        let formBarButton = UIBarButtonItem(customView: formButton)
        let settingsBarButton = UIBarButtonItem(customView: settingsButton)

        navigationItem.rightBarButtonItems = [formBarButton, settingsBarButton]
        navigationItem.title = Date.today

        view.addSubview(tableView)
    }

    func configureDelegates() {
        viewModel.delegate = self
    }

    func configureBind() {
        formButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.viewModel.didTappedFormButton()
            })
            .disposed(by: disposeBag)

        settingsButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.viewModel.didTappedSettingsButton()
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
            .subscribe(onNext: { [weak self] indexPath in
                guard let cell = self?.tableView.cellForRow(at: indexPath) as? TasksTableViewCell,
                      let task = self?.viewModel.allTasks.value[indexPath.row] else { return }

                self?.viewModel.updateIsChecked(of: task, value: !task.isChecked)
                cell.updateUI(by: task)
            })
            .disposed(by: disposeBag)

        tableView.rx.itemDeleted
            .subscribe(onNext: { [weak self] indexPath in
                self?.viewModel.deleteTask(of: indexPath.row)
            })
            .disposed(by: disposeBag)
    }

    func configureConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func configureObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(fetchAllTasks),
                                               name: Self.formDismissed,
                                               object: nil)
    }
}

extension TasksViewController: TasksViewModelDelegate {
    func didTappedFormButton() {
        let formViewController = FormViewController()

        present(formViewController, animated: true)
    }
    
    func didTappedSettingsButton() {
        let settingsViewController = SettingsViewController()

        navigationController?.pushViewController(settingsViewController, animated: true)
    }
}
