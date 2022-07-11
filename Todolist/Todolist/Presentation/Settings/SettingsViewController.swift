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
    private static let identifier = "UITableViewCell"

    private let viewModel = SettingsViewModel()
    private let disposeBag = DisposeBag()
    private let dataSource = RxTableViewSectionedReloadDataSource<SettingsTableViewCellModel>(
        configureCell: { dataSource, tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingsViewController.identifier,
                                                     for: indexPath)
            var content = cell.defaultContentConfiguration()
            content.text = item
            cell.contentConfiguration = content
            cell.accessoryType = .disclosureIndicator
            return cell
        }
    )

    private lazy var settingsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: SettingsViewController.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        configureViews()
        configureConstraints()
        configureRx()
    }
    
    private func configureViews() {
        view.backgroundColor = .systemBackground
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "설정"
        
        view.addSubview(settingsTableView)
                
        dataSource.titleForHeaderInSection = { dataSource, index in
            return dataSource.sectionModels[index].title
        }
    }
    
    private func configureConstraints() {
        settingsTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func configureRx() {
        Observable.just(viewModel.items)
            .bind(to: settingsTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}
