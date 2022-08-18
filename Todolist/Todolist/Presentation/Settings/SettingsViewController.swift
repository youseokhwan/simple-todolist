//
//  SettingsViewController.swift
//  Todolist
//
//  Created by 유석환 on 2022/06/24.
//

import UIKit

import RxCocoa
import RxDataSources
import RxRelay
import RxSwift
import SnapKit

final class SettingsViewController: UIViewController {
    typealias SectionDataSource = RxTableViewSectionedReloadDataSource<SettingsSection>

    private let viewModel = SettingsViewModel()
    private let disposeBag = DisposeBag()

    private lazy var doneBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil)

        return barButtonItem
    }()
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)

        tableView.register(SettingsTableViewCell.self,
                           forCellReuseIdentifier: SettingsTableViewCell.identifier)
        tableView.rowHeight = 44
                         
        return tableView
    }()
    private lazy var themeLabel: UILabel = {
        let label = UILabel()

        label.text = Const.lightTheme
        label.sizeToFit()

        return label
    }()
    private lazy var dataSource: SectionDataSource = {
        let dataSource = SectionDataSource(
            configureCell: { [weak self] dataSource, tableView, indexPath, item in
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: SettingsTableViewCell.identifier,
                    for: indexPath
                ) as? SettingsTableViewCell else { return UITableViewCell() }

                if item == Const.themeSettings {
                    cell.accessoryView = self?.themeLabel
                }

                cell.update(title: item)

                return cell
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

        navigationItem.title = Const.settingsTitle
        navigationItem.rightBarButtonItem = doneBarButtonItem

        view.addSubview(tableView)
    }

    func configureBind() {
        doneBarButtonItem.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.dismiss(animated: true)
            })
            .disposed(by: disposeBag)

        Observable.just(viewModel.items)
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        viewModel.appearence
            .subscribe(onNext: { [weak self] index in
                self?.view.window?.overrideUserInterfaceStyle = UIUserInterfaceStyle(
                    rawValue: index
                ) ?? .unspecified
                UserDefaultsRepository.saveAppearance(value: index)
            })
            .disposed(by: disposeBag)

        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                let title = self?.viewModel.items[indexPath.section].items[indexPath.row]
                let viewController = OpenSourceLicenseViewController()

                if title == Const.openSourceLicense {
                    self?.navigationController?.pushViewController(viewController, animated: true)
                }
            })
            .disposed(by: disposeBag)
    }

    func configureConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
