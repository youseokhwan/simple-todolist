//
//  PlaceholderTextView.swift
//  Todolist
//
//  Created by Jae Kyeong Ko on 2022/08/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

final class PlaceholderTextView: UITextView {
    private let disposeBag = DisposeBag()

    private lazy var label: UILabel = {
        let label = UILabel()

        label.textColor = .lightGray
        label.sizeToFit()

        return label
    }()

    convenience init(font: UIFont, placeholder: String) {
        self.init(frame: .zero)
        configure(font: font, placeholder: placeholder)
    }
}

private extension PlaceholderTextView {
    func configure(font: UIFont, placeholder: String) {
        configureViews(font: font, placeholder: placeholder)
        configureBind()
        configureConstraints()
    }

    func configureViews(font: UIFont, placeholder: String) {
        self.font = font
        label.font = .systemFont(ofSize: font.pointSize)
        label.text = placeholder

        addSubview(label)
    }

    func configureBind() {
        rx.text
            .orEmpty
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] text in
                self?.label.isHidden = !text.isEmpty
            })
            .disposed(by: disposeBag)
    }

    func configureConstraints() {
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.leading.equalToSuperview().inset(5)
        }
    }
}
