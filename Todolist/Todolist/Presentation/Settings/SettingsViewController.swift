//
//  SettingsViewController.swift
//  Todolist
//
//  Created by 유석환 on 2022/06/24.
//

import UIKit

import SnapKit

final class SettingsViewController: UIViewController {
    private let viewModel = SettingsViewModel()
    
    private lazy var settingsTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        configureViews()
        configureConstraints()
    }
    
    private func configureViews() {
        view.backgroundColor = .systemBackground
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "설정"
        
        view.addSubview(settingsTableView)
    }
    
    private func configureConstraints() {
        settingsTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
