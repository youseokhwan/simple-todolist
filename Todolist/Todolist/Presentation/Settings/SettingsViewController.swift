//
//  SettingsViewController.swift
//  Todolist
//
//  Created by 유석환 on 2022/06/24.
//

import UIKit

import RxCocoa
import RxDataSources
import RxSwift
import SnapKit

final class SettingsViewController: UIViewController {
    private let viewModel = SettingsViewModel()
    private let disposeBag = DisposeBag()

    private lazy var settingsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()
        
    private var tableViewDataSource = RxTableViewSectionedReloadDataSource<SettingsTableViewCellModel>(
        configureCell: { dataSource, tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            var content = cell.defaultContentConfiguration()
            content.text = item
            return cell
        })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        configureViews()
        configureRx()
        configureConstraints()
    }
    
    private func configureViews() {
        view.backgroundColor = .systemBackground
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "설정"
        
        view.addSubview(settingsTableView)
                
        tableViewDataSource.titleForHeaderInSection = { dataSource, index in
            return dataSource.sectionModels[index].headerTitle
        }
    }
    
    private func configureConstraints() {
        settingsTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func configureRx() {
        Observable.just(viewModel.items)
            .bind(to: settingsTableView.rx.items(dataSource: tableViewDataSource))
            .disposed(by: disposeBag)
    }
}
