//
//  TasksViewController.swift
//  Todolist
//
//  Created by 유석환 on 2022/06/24.
//

import RxSwift
import RxCocoa
import SnapKit
import UIKit

final class TasksViewController: UIViewController {
    private let viewModel = TasksViewModel()
    private let disposeBag = DisposeBag()
    
    private lazy var formButton = UIButton()
    private lazy var settingsButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        let buttonImageConfiguration = UIImage.SymbolConfiguration(pointSize: 25)
        formButton.setImage(UIImage(systemName: "plus", withConfiguration: buttonImageConfiguration), for: .normal)
        settingsButton.setImage(UIImage(systemName: "gearshape.fill", withConfiguration: buttonImageConfiguration), for: .normal)
        
        formButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.formButtonTapped()
            })
            .disposed(by: disposeBag)
        
        settingsButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.formButtonTapped()
            })
            .disposed(by: disposeBag)
        
        let formBarButton = UIBarButtonItem(customView: formButton)
        let settingsBarButton = UIBarButtonItem(customView: settingsButton)
        navigationItem.rightBarButtonItems = [formBarButton, settingsBarButton]
    }
    
    private func formButtonTapped() {
        let formViewController = FormViewController()
        navigationController?.pushViewController(formViewController, animated: true)
    }
    
    private func settingsButtonTapped() {
        let settingsViewController = SettingsViewController()
        navigationController?.pushViewController(settingsViewController, animated: true)
    }
}
