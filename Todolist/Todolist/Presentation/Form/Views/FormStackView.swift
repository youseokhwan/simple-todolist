//
//  FormStackView.swift
//  Todolist
//
//  Created by 유석환 on 2022/07/04.
//

import UIKit

import RxCocoa
import RxSwift

final class FormStackView: UIStackView {
    private lazy var titleView = FormTitleView()
    private lazy var dailyView = FormDailyView()

    var textFieldRx: Reactive<UITextField> {
        return titleView.textFieldRx
    }
    var switchRx: Reactive<UISwitch> {
        return dailyView.switchRx
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    func showKeyboard() {
        titleView.showKeyboard()
    }

    func updateCount() {
        titleView.updateCount()
    }
}

private extension FormStackView {
    func configure() {
        configureViews()
    }

    func configureViews() {
        axis = .vertical
        spacing = 10

        [titleView, dailyView].forEach {
            addArrangedSubview($0)
        }
    }
}
