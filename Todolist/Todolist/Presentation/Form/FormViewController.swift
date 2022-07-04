//
//  FormViewController.swift
//  Todolist
//
//  Created by 유석환 on 2022/06/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

final class FormViewController: UIViewController {
    private let viewModel = FormViewModel()
    private let disposeBag = DisposeBag()

    private lazy var addButton: UIButton = {
        let button = UIButton()
        let buttonImageConfiguration = UIImage.SymbolConfiguration(pointSize: 25)
        let image = UIImage(systemName: "checkmark")
        button.setImage(image, for: .normal)
        return button
    }()
    private lazy var scrollView = UIScrollView()
    private lazy var stackView = FormStackView()

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

        let addBarButton = UIBarButtonItem(customView: addButton)
        navigationItem.rightBarButtonItem = addBarButton

        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
    }

    private func configureConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        stackView.snp.makeConstraints { make in
            make.top.bottom.centerX.width.equalToSuperview()
        }
    }

    private func configureRx() {
        addButton.rx.tap
            .subscribe(onNext: {
                print("addButton 클릭") // TODO: 임시 메소드
            })
            .disposed(by: disposeBag)
    }
}
