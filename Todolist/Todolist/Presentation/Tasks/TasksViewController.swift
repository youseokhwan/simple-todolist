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
        button.setImage(UIImage(systemName: "plus",
                                withConfiguration: buttonImageConfiguration), for: .normal)
        return button
    }()
    private lazy var settingsButton: UIButton = {
        let button = UIButton()
        let buttonImageConfiguration = UIImage.SymbolConfiguration(pointSize: 25)
        button.setImage(UIImage(systemName: "gearshape.fill",
                                withConfiguration: buttonImageConfiguration), for: .normal)
        return button
    }()
    private lazy var tasksTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        configureViews()
        configureDelegates()
        configureConstraints()
        configureRx()
    }
    
    private func configureDelegates() {
        viewModel.delegate = self
    }
    
    private func configureViews() {
        view.backgroundColor = .systemBackground

        let formBarButton = UIBarButtonItem(customView: formButton)
        let settingsBarButton = UIBarButtonItem(customView: settingsButton)
        navigationItem.rightBarButtonItems = [formBarButton, settingsBarButton]
        navigationItem.title = viewModel.currentDate

        tasksTableView.register(TasksTableViewCell.self,
                                forCellReuseIdentifier: TasksTableViewCell.identifier)
        tasksTableView.rowHeight = 80
        view.addSubview(tasksTableView)
    }

    private func configureConstraints() {
        tasksTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func configureRx() {
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
        
        viewModel.tasksObserver
            .bind(to: tasksTableView.rx.items(cellIdentifier: TasksTableViewCell.identifier,
                                              cellType: TasksTableViewCell.self)) { index, element, cell in
                cell.contentContainerView.bind(task: element)
            }
            .disposed(by: disposeBag)
    }
}

extension TasksViewController: TasksViewModelDelegate {
    func didTappedFormButton() {
        let formViewController = FormViewController()
        navigationController?.pushViewController(formViewController, animated: true)
    }
    
    func didTappedSettingsButton() {
        let settingsViewController = SettingsViewController()
        navigationController?.pushViewController(settingsViewController, animated: true)
    }
}
