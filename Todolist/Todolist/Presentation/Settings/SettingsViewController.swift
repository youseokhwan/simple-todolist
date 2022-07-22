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
    typealias SectionDataSource = RxTableViewSectionedReloadDataSource<SettingsSection>

    private let viewModel = SettingsViewModel()
    private let disposeBag = DisposeBag()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)

        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: Const.settingsTableViewCellID)
        tableView.register(ThemeTableViewCell.self,
                           forCellReuseIdentifier: ThemeTableViewCell.identifier)
                         
        return tableView
    }()
    private lazy var dataSource: SectionDataSource = {
        let dataSource = SectionDataSource(
            configureCell: { dataSource, tableView, indexPath, item in
                switch dataSource[indexPath] {
                case .Default(title: let title):
                    let cell = tableView.dequeueReusableCell(
                        withIdentifier: Const.settingsTableViewCellID,
                        for: indexPath
                    )
                    var content = cell.defaultContentConfiguration()

                    content.text = title
                    cell.contentConfiguration = content
                    cell.accessoryType = .disclosureIndicator

                    return cell
                case .Theme(title: let title, currentTheme: let currentTheme):
                    guard let cell = tableView.dequeueReusableCell(
                        withIdentifier: ThemeTableViewCell.identifier,
                        for: indexPath
                    ) as? ThemeTableViewCell else { return UITableViewCell() }

                    cell.update(title: title, currentTheme: currentTheme)

                    return cell
                }
            }
        )

        dataSource.titleForHeaderInSection = { dataSource, index in
            return dataSource.sectionModels[index].title
        }

        return dataSource
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

private extension SettingsViewController {
    func configure() {
        configureViews()
        configureBind()
        configureConstraints()
    }

    func configureViews() {
        view.backgroundColor = .systemBackground

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = Const.settingsTitle

        view.addSubview(tableView)
    }

    func configureBind() {
        Observable.just(viewModel.items)
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }

    func configureConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
