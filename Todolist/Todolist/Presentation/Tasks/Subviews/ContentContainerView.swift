//
//  ContentContainerView.swift
//  Todolist
//
//  Created by Jae Kyeong Ko on 2022/06/30.
//

import UIKit

import SnapKit

final class ContentContainerView: UIView {
    private lazy var contextLabel = UILabel()
    private lazy var endDateLabel = UILabel()
    private lazy var publisedDateLabel = UILabel()
    private lazy var checkButton: UIButton = {
        let button = UIButton()
        let configure = UIImage.SymbolConfiguration(pointSize: 25)
        button.setImage(UIImage(systemName: "circle",
                                withConfiguration: configure), for: .normal)
        button.setImage(UIImage(systemName: "checkmark.circle.fill",
                                withConfiguration: configure), for: .selected)
        button.tintColor = .systemGreen
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
        layer.cornerRadius = 10
        backgroundColor = .systemGray

        [contextLabel, endDateLabel, publisedDateLabel, checkButton].forEach {
            addSubview($0)
        }
    }

    private func configureConstraints() {
        checkButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(30)
        }

        contextLabel.snp.makeConstraints { make in
            make.leading.equalTo(checkButton.snp.trailing).offset(20)
            make.top.equalToSuperview().offset(15)
        }

        publisedDateLabel.snp.makeConstraints { make in
            make.leading.equalTo(checkButton.snp.trailing).offset(20)
            make.top.equalTo(contextLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }

        endDateLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(contextLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
    }

    func update(task: Task) {
        contextLabel.text = task.context
        endDateLabel.text = task.endDate?.yearMonthDay ?? ""
        publisedDateLabel.text = task.publishedDate.yearMonthDay
    }
}
