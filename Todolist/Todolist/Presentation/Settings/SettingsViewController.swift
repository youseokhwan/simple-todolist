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
        let font = UIFont.instance(.theCircleB, size: 18)

        barButtonItem.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)

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

        label.text = String(.lightThemeItem)
        label.sizeToFit()

        return label
    }()
    private lazy var versionLabel: UILabel = {
        let label = UILabel()

        label.textColor = .lightGray

        return label
    }()

    private lazy var dataSource: SectionDataSource = {
        let dataSource = SectionDataSource(
            configureCell: { [weak self] dataSource, tableView, indexPath, item in
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: SettingsTableViewCell.identifier,
                    for: indexPath
                ) as? SettingsTableViewCell else { return UITableViewCell() }

                if item == String(.themeItem) {
                    cell.accessoryView = self?.themeLabel
                } else if item == String(.versionItem) {
                    cell.accessoryView = self?.versionLabel
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

    private func openMailApp() {
        if let url = URL(string: String(.emailURL)) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
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

        navigationItem.title = String(.settings)
        navigationItem.rightBarButtonItem = doneBarButtonItem

        versionLabel.text = viewModel.appVersionText()
        versionLabel.sizeToFit()

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
                let viewController = SettingsLicenseViewController()

                if title == String(.licenseItem) {
                    self?.navigationController?.pushViewController(viewController, animated: true)
                } else if title == String(.contactUsItem) {
                    self?.openMailApp()
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
