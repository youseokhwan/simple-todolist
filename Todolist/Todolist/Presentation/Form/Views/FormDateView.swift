//
//  FormDateView.swift
//  Todolist
//
//  Created by 유석환 on 2022/08/29.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

final class FormDateView: UIView {
    private lazy var titleLabel = UILabel()
    private lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()

        picker.datePickerMode = .date
        picker.timeZone = .autoupdatingCurrent

        return picker
    }()

    var title = "" {
        didSet {
            titleLabel.text = title
        }
    }
    var datePickerRx: Reactive<UIDatePicker> {
        return datePicker.rx
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
}

private extension FormDateView {
    func configure() {
        configureViews()
        configureConstraints()
    }

    func configureViews() {
        [titleLabel, datePicker].forEach {
            addSubview($0)
        }
    }

    func configureConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerY.leading.height.equalToSuperview()
            make.width.equalTo(70)
        }

        datePicker.snp.makeConstraints { make in
            make.centerY.height.equalToSuperview()
            make.leading.equalTo(titleLabel.snp.trailing).offset(20)
            make.width.equalTo(80)
        }
    }
}
