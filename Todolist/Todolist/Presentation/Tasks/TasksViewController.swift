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
        bind()
    }
    
    private func configure() {
        view.backgroundColor = .systemBackground
        tasksTableView.register(TasksTableViewCell.self,
                                forCellReuseIdentifier: TasksTableViewCell.identifier)
        configureDelegate()
        configureNavigation()
        configureView()
    }
    
    private func configureDelegate() {
        viewModel.delegate = self
    }
    
    private func configureNavigation() {
        let formBarButton = UIBarButtonItem(customView: formButton)
        let settingsBarButton = UIBarButtonItem(customView: settingsButton)
        navigationItem.rightBarButtonItems = [formBarButton, settingsBarButton]
        navigationItem.title = viewModel.currentDate
    }
    
    private func configureView() {
        tasksTableView.rowHeight = 80
        view.addSubview(tasksTableView)
        
        tasksTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func bind() {
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
