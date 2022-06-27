//
//  TasksViewController.swift
//  Todolist
//
//  Created by 유석환 on 2022/06/24.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit

final class TasksViewController: UIViewController {
    private let viewModel = TasksViewModel()
    private let disposeBag = DisposeBag()
    
    private lazy var formButton: UIButton = {
        let button = UIButton()
        let buttonImageConfiguration = UIImage.SymbolConfiguration(pointSize: 25)
        button.setImage(UIImage(systemName: "plus", withConfiguration: buttonImageConfiguration), for: .normal)
        return button
    }()
    private lazy var settingsButton: UIButton = {
        let button = UIButton()
        let buttonImageConfiguration = UIImage.SymbolConfiguration(pointSize: 25)
        button.setImage(UIImage(systemName: "gearshape.fill", withConfiguration: buttonImageConfiguration), for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        bind()
    }
    
    private func configure() {
        configureNavigation()
        configureDelegate()
        view.backgroundColor = .systemBackground
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
