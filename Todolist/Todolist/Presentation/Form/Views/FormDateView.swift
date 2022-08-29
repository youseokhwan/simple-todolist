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

    var title = "" {
        didSet {
            titleLabel.text = title
        }
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
        [titleLabel].forEach {
            addSubview($0)
        }
    }

    func configureConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerY.leading.height.equalToSuperview()
            make.width.equalTo(70)
        }
    }
}
