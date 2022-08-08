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
                           forCellReuseIdentifier: Const.tasksTableViewCellID)
        tableView.rowHeight = 80

        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchAllTasks()
    }
}

private extension TasksViewController {
    func configure() {
        configureViews()
        configureDelegates()
        configureBind()
        configureConstraints()
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
                cellIdentifier: Const.tasksTableViewCellID,
                cellType: TasksTableViewCell.self
            )) { [weak self] index, element, cell in
                cell.updateUI(by: element)
                cell.checkButtonTappedHandler = { [weak self] value in
                    self?.viewModel.updateIsChecked(of: element, value: value)
                }
            }
            .disposed(by: disposeBag)

        tableView.rx.itemSelected
            .map { [weak self] indexPath in
                self?.viewModel.allTasks.value[indexPath.row]
            }
            .subscribe(onNext: { [weak self] task in
                if let task = task {
                    let controller = FormViewController(task: task)

                    self?.navigationController?.pushViewController(controller, animated: true)
                }
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
