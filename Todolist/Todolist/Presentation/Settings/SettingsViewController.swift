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

        tableView.register(SettingsTableViewCell.self,
                           forCellReuseIdentifier: Const.settingsTableViewCellID)
                         
        return tableView
    }()
    private lazy var dataSource: SectionDataSource = {
        let dataSource = SectionDataSource(
            configureCell: { dataSource, tableView, indexPath, item in
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: Const.settingsTableViewCellID,
                    for: indexPath
                ) as? SettingsTableViewCell else { return UITableViewCell() }

                if item == Const.themeSettings {
                    cell.accessoryView = self.makeMenuButton()
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkAppearance(self)
    }

    private func makeMenuButton() -> UIButton {
        let button = UIButton()
        let children = [Const.systemTheme, Const.lightTheme, Const.darkTheme]
            .enumerated()
            .map { index, value in
                return UIAction(title: value) { [weak self] action in
                    self?.overrideUserInterfaceStyle = UIUserInterfaceStyle(
                        rawValue: index
                    ) ?? .unspecified

                    UserDefaultsRepository.saveAppearance(value: index)

                    button.setTitle(value, for: .normal)
                    button.sizeToFit()
                }
        }

        switch UserDefaultsRepository.currentAppearance() {
        case 0 :
            button.setTitle(Const.systemTheme, for: .normal)
        case 1:
            button.setTitle(Const.lightTheme, for: .normal)
        case 2:
            button.setTitle(Const.darkTheme, for: .normal)
        default:
            button.setTitle(Const.systemTheme, for: .normal)
        }

        button.setTitleColor(.systemBlue, for: .normal)
        button.sizeToFit()
        button.menu = UIMenu(title: Const.themeMenuTitle,
                             options: .displayInline,
                             children: children)

        return button
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
