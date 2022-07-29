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

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)

        tableView.register(SettingsTableViewCell.self,
                           forCellReuseIdentifier: Const.settingsTableViewCellID)
                         
        return tableView
    }()
    private lazy var themeButton: ThemeMenuButton = {
        var button: ThemeMenuButton

        if #available(iOS 14.0, *) {
            button = ThemeMenuButton() { [weak self] index in
                self?.viewModel.appearence.accept(index)
            }
        } else {
            button = ThemeMenuButton()
        }

        return button
    }()
    private lazy var dataSource: SectionDataSource = {
        let dataSource = SectionDataSource(
            configureCell: { [weak self] dataSource, tableView, indexPath, item in
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: Const.settingsTableViewCellID,
                    for: indexPath
                ) as? SettingsTableViewCell else { return UITableViewCell() }

                if item == Const.themeSettings {
                    cell.accessoryView = self?.themeButton
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

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = Const.settingsTitle

        view.addSubview(tableView)
    }

    func configureBind() {
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

        if #unavailable(iOS 14.0) {
            themeButton.rx.tap
                .subscribe(onNext: { [weak self] in
                    guard let themes = self?.themeButton.themes else { return }
                    let controller = ThemeAlertController(children: themes) { [weak self] index in
                        self?.viewModel.appearence.accept(index)
                        self?.themeButton.setTitle(themes[index], for: .normal)
                        self?.themeButton.sizeToFit()
                    }

                    self?.present(controller, animated: true)
                })
                .disposed(by: disposeBag)
        }
    }

    func configureConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
