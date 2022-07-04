//
//  FormDateView.swift
//  Todolist
//
//  Created by 유석환 on 2022/07/04.
//

import UIKit

final class FormDateView: UIView {
    private lazy var label: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemBlue // TODO: UI 작업 후 삭제
        label.text = "시작일"
        return label
    }()
    private lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen // TODO: UI 작업 후 삭제
        button.setTitle("2022.07.04(월)", for: .normal)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    private func configure() {
        configureViews()
        configureConstraints()
    }

    private func configureViews() {
        [label, button].forEach {
            addSubview($0)
        }
    }

    private func configureConstraints() {
        label.snp.makeConstraints { make in
            make.leading.height.equalToSuperview()
            make.width.equalTo(100)
        }

        button.snp.makeConstraints { make in
            make.leading.equalTo(label.snp.trailing).offset(30)
            make.height.equalToSuperview()
        }
    }

    // TODO: 디자인 작업용 메소드. 실제 로직에서는 사용 x
    func updateText(label: String, button: String) {
        self.label.text = label
        self.button.setTitle(button, for: .normal)
    }
}
