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

    private lazy var themeActionSheetButton = ThemeActionSheetButton()
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)

        tableView.register(SettingsTableViewCell.self,
                           forCellReuseIdentifier: Const.settingsTableViewCellID)
                         
        return tableView
    }()
    private lazy var dataSource: SectionDataSource = {
        let dataSource = SectionDataSource(
            configureCell: { [weak self] dataSource, tableView, indexPath, item in
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: Const.settingsTableViewCellID,
                    for: indexPath
                ) as? SettingsTableViewCell else { return UITableViewCell() }

                if item == Const.themeSettings {
                    if #available(iOS 14.0, *) {
                        cell.accessoryView = ThemeMenuButton()
                    } else {
                        cell.accessoryView = self?.themeActionSheetButton
                    }
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

    private func showActionSheet() {
        let alertController = UIAlertController(title: Const.themeMenuTitle,
                                                message: nil,
                                                preferredStyle: .actionSheet)
        let themes = [Const.systemTheme, Const.lightTheme, Const.darkTheme]
        let actions = themes.enumerated().map { index, value in
            return UIAlertAction(title: value, style: .default) { [weak self] action in
                self?.view.window?.overrideUserInterfaceStyle = UIUserInterfaceStyle(
                    rawValue: index
                ) ?? .unspecified

                UserDefaultsRepository.saveAppearance(value: index)

                self?.themeActionSheetButton.setTitle(value, for: .normal)
                self?.themeActionSheetButton.sizeToFit()
            }
        }

        actions.forEach {
            alertController.addAction($0)
        }

        present(alertController, animated: true)
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

        themeActionSheetButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.showActionSheet()
            })
            .disposed(by: disposeBag)
    }

    func configureConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
